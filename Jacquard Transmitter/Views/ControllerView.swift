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

  @State private var observer: Cancellable? = nil
  @State private var lastGestures: [String] = []

  var body: some View {
    VStack {
      Text("\(multipeerDevices.availablePeers.count) 💻").font(.system(size: 36)).bold()
      Text("Ready to transmit").padding(.top).dynamicTypeSize(.medium)
      Text("Your ID: \(String((multipeerDevices.transceiver!.localPeerId ?? "").prefix(8)))").dynamicTypeSize(.small)
      
      LastGesture(lastGestures: self.$lastGestures)

      MultipeerDevicesView(
        peerSelector: peerSelector,
        multipeerDevices: multipeerDevices
      )
    }.task {
      // start multipeer
      multipeerDevices.transceiver!.resume()

      // register notification
      jacquardTag?.registerSubscriptions { subscribableTag in
        print("subscribe")
        
        // sink returns cancellable type, need to store somewhere because if it's destroy then it won't be called
        self.observer = subscribableTag
          .subscribe(GestureNotificationSubscription())
          .sink {
            notification in
            print("name: \(notification.name), rawValue: \(notification.rawValue), hashValue: \(notification.hashValue)")
            
            self.lastGestures.append(notification.name)
            
            if (!self.peerSelector.selectedPeers.isEmpty) {
              multipeerDevices.transceiver!.send(TransmitterPayload(gesture: notification.name), to: self.peerSelector.selectedPeers)
            }
          }
      }
    }
  }
}
