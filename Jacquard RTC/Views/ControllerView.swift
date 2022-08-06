//
//  ControllerView.swift
//  Jacquard RTC
//
//  Created by Phumrapee Limpianchop on 2022/08/05.
//

import SwiftUI

import Combine
import JacquardSDK
import MultipeerKit

final class ViewModel: ObservableObject {
  @Published var message: String = ""
  @Published var selectedPeers: [MultipeerKit.Peer] = []

  func toggle(_ peer: MultipeerKit.Peer) {
    if selectedPeers.contains(peer) {
      selectedPeers.remove(at: selectedPeers.firstIndex(of: peer)!)
    } else {
      selectedPeers.append(peer)
    }
  }
}

struct ControllerView: View {
  @ObservedObject private(set) var viewModel = ViewModel()
  
  @Binding var jacquardTag: ConnectedTag?

  @State private var dataSource: MultipeerDataSource? = nil
  @State private var observer: Cancellable? = nil
  @State private var lastGestures: [String] = []

  let transceiver = MultipeerTransceiver(configuration: MultipeerConfiguration(
    serviceType: "JacquardRTC",
    peerName: "Transmitter - iOS",
    defaults: .standard,
    security: .default,
    invitation: .automatic
  ))

  var body: some View {
    VStack {
      Text("\(dataSource?.availablePeers.count ?? -1) 💻").dynamicTypeSize(.xLarge).bold()
      Text("Ready to transmit").padding().dynamicTypeSize(.medium)
      
      List {
        Section {
          ForEach(lastGestures.reversed().prefix(8), id: \.self) { lastGesture in
            Text(lastGesture)
          }
        } header: {
          Text("Last Gestures")
        }
      }
    }.task {
      // start multipeer
      transceiver.resume()
      
      // observe datasource
      self.dataSource = MultipeerDataSource(transceiver: transceiver)

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
            self.transceiver.broadcast(TransmitterPayload(gesture: notification.name))
          }
      }
    }
  }
}
