//
//  PeerSelector.swift
//  macOS
//
//  Created by Phumrapee Limpianchop on 2022/08/07.
//

import Foundation
import MultipeerKit

class PeerSelector: ObservableObject {
  @Published var selfInjectedPeers: [Peer] = []
  @Published var selectedPeers: [Peer] = []
  
  func injectPeer(_ peer: Peer) {
    if (!selfInjectedPeers.contains(peer)) {
      selfInjectedPeers.append(peer)
    }
  }
  
  func toggle(_ peer: Peer) {
    if (selectedPeers.contains(peer)) {
      selectedPeers.remove(at: selectedPeers.firstIndex(of: peer)!)
    } else {
      selectedPeers.append(peer)
    }
  }
}
