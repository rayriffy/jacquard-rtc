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
    await jacquardActivityCard?.update(using: .init(
      foundPeersCount: multipeerDevices.availablePeers.count,
      selectedPeersCount: peerSelector.selectedPeers.count,
      gesture: .init(
        lastGestureName: lastGestures.last ?? "None",
        lastGestureSentTime: lastGestureSentDate,
        sentAmount: lastGestures.count
      )
    ))
  }

  var body: some View {
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
        await jacquardActivityCard?.end(using: .none, dismissalPolicy: .immediate)
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
            
            if (!self.peerSelector.selectedPeers.isEmpty) {
              multipeerDevices.transceiver!.send(TransmitterPayload(gesture: notification.name), to: self.peerSelector.selectedPeers)
            }
            
            Task {
              self.lastGestures.append(notification.name)
              self.lastGestureSentDate = .now

              await updateLiveActivity()
            }
          }

        self.observers.append(gestureNotification)
      }
      
      //
      let peerSelectorSink = peerSelector.$selectedPeers.sink { _ in
        Task { await updateLiveActivity() }
      }
      let multipeerDevicesSink = multipeerDevices.$availablePeers.sink { _ in
        Task { await updateLiveActivity() }
      }

      self.observers.append(peerSelectorSink)
      self.observers.append(multipeerDevicesSink)

      // create live activity view
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
