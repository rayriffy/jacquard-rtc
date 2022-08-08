//
//  ControllerView.swift
//  Jacquard Transmitter
//
//  Created by Phumrapee Limpianchop on 2022/08/05.
//

import ActivityKit
import SwiftUI
import Combine
import JacquardSDK
import MultipeerKit

struct ControllerView: View {
  @Binding var jacquardTag: ConnectedTag?
  
  @StateObject var peerSelector: PeerSelector = PeerSelector()
  @StateObject var multipeerDevices: MultipeerDevices = MultipeerDevices()

  @State private var observers: [Cancellable] = []
  @State private var lastGestures: [String] = []
  @State private var lastGestureSentDate: Date = .now
  
  @State private var jacquardActivityCard: Activity<JacquardActivityAttributes>? = nil
  
  func updateLiveActivity() async {
    do {
      try await jacquardActivityCard?.update(using: .init(
        foundPeersCount: multipeerDevices.availablePeers.count,
        selectedPeersCount: peerSelector.selectedPeers.count,
        gesture: .init(
          lastGestureName: lastGestures.last ?? "None",
          lastGestureSentTime: lastGestureSentDate,
          sentAmount: lastGestures.count
        )
      ))
    } catch(let error) {
      print("failed to update live activity: \(error.localizedDescription)")
    }
  }

  var body: some View {
    let selectedPeersSink = peerSelector.$selectedPeers.sink { _ in
      Task { print("update"); await updateLiveActivity() }
    }
    let availablePeersSink = multipeerDevices.$availablePeers.sink { _ in
      Task { print("update"); await updateLiveActivity() }
    }

    VStack {
      ZStack {
        VStack {
          Text("**\(multipeerDevices.availablePeers.count) 💻**")
            .font(.system(size: 36))
          Text("Ready to transmit").padding(.top).dynamicTypeSize(.medium)
          Text("Device ID: `\(String((multipeerDevices.transceiver!.localPeerId ?? "").prefix(8)))`")
            .dynamicTypeSize(.small)
            .padding(.bottom, 4)
        }
        
        BatteryIndicator(jacquardTag: self.$jacquardTag, observers: self.$observers)
      }
      
      LastGesture(lastGestures: self.$lastGestures)
      
      MultipeerDevicesView(
        peerSelector: peerSelector,
        multipeerDevices: multipeerDevices
      )
    }
    .onDisappear {
      // stop broadcasting before view disappear
      multipeerDevices.transceiver?.stop()
      
      // stop live activity
      Task {
        do {
          try await jacquardActivityCard?.end(using: .none, dismissalPolicy: .immediate)
        } catch(let error) {
          print("failed to end live activity: \(error.localizedDescription)")
        }
      }
    }
    .task {
      // start multipeer
      multipeerDevices.transceiver!.resume()

      // register notification
      jacquardTag?.registerSubscriptions { subscribableTag in
        // sink returns cancellable type, need to store somewhere because if it's destroy then it won't be called
        let gestureNotification = subscribableTag
          .subscribe(GestureNotificationSubscription())
          .sink {
            notification in
            print("name: \(notification.name), rawValue: \(notification.rawValue), hashValue: \(notification.hashValue)")
            
            self.lastGestures.append(notification.name)
            
            if (!self.peerSelector.selectedPeers.isEmpty) {
              multipeerDevices.transceiver!.send(TransmitterPayload(gesture: notification.name), to: self.peerSelector.selectedPeers)
              self.lastGestureSentDate = .now
            }
            
            Task {
              await updateLiveActivity()
            }
          }
        
        self.observers.append(gestureNotification)
      }
      
      // create live activity view
      let jacquardActivityAttributes = JacquardActivityAttributes(jacquardDisplayName: jacquardTag?.displayName ?? "")
      let initialState = JacquardActivityAttributes.JacquardActivityStatus(
        foundPeersCount: 0,
        selectedPeersCount: 0,
        gesture: .init(lastGestureName: "", lastGestureSentTime: .now, sentAmount: 0)
      )

      do {
        let jacquardActivity = try Activity<JacquardActivityAttributes>.request(
          attributes: .init(
            jacquardDisplayName: jacquardTag?.displayName ?? ""
          ),
          contentState: .init(
            foundPeersCount: 0,
            selectedPeersCount: 0,
            gesture: .init(lastGestureName: "None", lastGestureSentTime: .now, sentAmount: 0)
          ),
          pushType: nil
        )
        
        self.jacquardActivityCard = jacquardActivity
        print("live activity created: \(jacquardActivity.id)")
      } catch (let error) {
        print("failed requesting live activity: \(error.localizedDescription)")
      }
    }
  }
}
