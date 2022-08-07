//
//  MultipeerDevices.swift
//  Jacquard RTC
//
//  Created by Phumrapee Limpianchop on 2022/08/07.
//

import SwiftUI
import MultipeerKit

struct MultipeerDevicesView: View {
  @ObservedObject var peerSelector: PeerSelector
  @ObservedObject var multipeerDevices: MultipeerDevices
  
  @State private var isInjectedPeerPopover: Bool = false
  @State private var isInjectedPeerEnabled: Bool = false

  var body: some View {
    List {
      Section {
        if (self.isInjectedPeerEnabled) {
          ForEach(self.peerSelector.selfInjectedPeers) { peer in
            PeerToggle(peerSelector: peerSelector, peer: peer)
          }
          Divider()
        }
        ForEach(multipeerDevices.availablePeers) { peer in
          PeerToggle(peerSelector: peerSelector, peer: peer)
        }
      } header: {
        HStack {
          Text("Found devices")

          Spacer()

          Button(action: {
            self.isInjectedPeerPopover.toggle()
          }, label: {
            Image(systemName: "gear")
          })
            .buttonStyle(.borderless)
            .popover(
              isPresented: self.$isInjectedPeerPopover,
              arrowEdge: .bottom,
              content: {
                HStack {
                  Toggle("Show manually injected peers", isOn: self.$isInjectedPeerEnabled)
                }.padding(12)
              }
            )
        }
      }
    }
  }
}
