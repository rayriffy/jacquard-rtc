//
//  MultipeerDevices.swift
//  Jacquard RTC
//
//  Created by Phumrapee Limpianchop on 2022/08/07.
//

import Foundation
import SwiftUI
import MultipeerKit

class MultipeerDevices: ObservableObject {
  @Published var availablePeers: [Peer] = []

  @Published var transceiver: MultipeerTransceiver? = nil

  init() {
    #if canImport(UIKit)
      self.transceiver = MultipeerTransceiver(configuration: MultipeerConfiguration(
        serviceType: "JacquardRTC",
        peerName: UIDevice.current.name,
        defaults: .standard,
        security: .default,
        invitation: .automatic
      ))
    #else
      self.transceiver = MultipeerTransceiver(configuration: MultipeerConfiguration(
        serviceType: "JacquardRTC",
        peerName: Host.current().localizedName ?? "Unknown Device",
        defaults: .standard,
        security: .default,
        invitation: .automatic
      ))
    #endif

    transceiver!.availablePeersDidChange =  { peers in
      self.availablePeers = peers
    }
  }
}
