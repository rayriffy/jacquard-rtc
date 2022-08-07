//
//  PeerToggle.swift
//  Jacquard RTC
//
//  Created by Phumrapee Limpianchop on 2022/08/07.
//

import SwiftUI
import MultipeerKit

struct PeerToggle: View {
  @ObservedObject var peerSelector: PeerSelector
  var peer: Peer

  var body: some View {
    HStack {
      Circle()
        .frame(width: 12, height: 12)
        .foregroundColor(peer.isConnected ? .green : .gray)
      
      Text("\(peer.name) (`\(String(peer.id.prefix(8)))`)")
      
      Spacer()
      
      if self.peerSelector.selectedPeers.contains(peer) {
        Image(systemName: "checkmark")
      }
    }.onTapGesture {
      self.peerSelector.toggle(peer)
    }
  }
}
