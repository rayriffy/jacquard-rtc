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
  @EnvironmentObject var dataSource: MultipeerDataSource

  let transceiver = MultipeerTransceiver()

  init(jacquardTag: ConnectedTag?) {
    print("controller view init")
    print("jacquardTag")
    print(jacquardTag)
    transceiver.resume()

    jacquardTag?.registerSubscriptions { subscribableTag in
      self.subcribeGestureData(subscribableTag)
    }
  }

  private func subcribeGestureData(_ tag: SubscribableTag) {
    tag
      .subscribe(GestureNotificationSubscription())
      .sink {
        notification in
        guard let self = self else { return }
        print("name: \(notification.name), rawValue: \(notification.rawValue), hashValue: \(notification.hashValue)")
        self.transceiver.broadcast(TransmitterPayload(gesture: notification.name))
      }
  }

  var body: some View {
    VStack {
      Text("Ready to transmit")
      List {
        ForEach(dataSource.availablePeers) { peer in
          HStack {
            Circle()
              .frame(width: 12, height: 12)
              .foregroundColor(peer.isConnected ? .green : .gray)

            Text(peer.name)

            Spacer()

            if self.viewModel.selectedPeers.contains(peer) {
              Image(systemName: "checkmark")
            }
          }.onTapGesture {
            self.viewModel.toggle(peer)
          }
        }
      }
    }
  }
}

// struct ControllerView_Previews: PreviewProvider {
//  static var previews: some View {
//    ControllerView()
//  }
// }
