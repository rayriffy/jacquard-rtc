//
//  ControllerView.swift
//  Jacquard Transmitter
//
//  Created by Phumrapee Limpianchop on 2022/08/05.
//

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
            }
          }
        
        self.observers.append(gestureNotification)
      }
    }
  }
}
