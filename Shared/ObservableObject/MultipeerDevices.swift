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
  
  private var serviceType: String = "JacquardRTC"
  private var security = MultipeerConfiguration.Security(
    identity: nil,
    encryptionPreference: .required,
    invitationHandler: { _, _, closure in
      closure(true)
    }
  )

  init() {
    #if canImport(UIKit)
      self.transceiver = MultipeerTransceiver(configuration: MultipeerConfiguration(
        serviceType: serviceType,
        peerName: UIDevice.current.name,
        defaults: .standard,
        security: security,
        invitation: .automatic
      ))
    #else
      self.transceiver = MultipeerTransceiver(configuration: MultipeerConfiguration(
        serviceType: serviceType,
        peerName: Host.current().localizedName ?? "Unknown Device",
        defaults: .standard,
        security: security,
        invitation: .automatic
      ))
    #endif

    transceiver!.availablePeersDidChange =  { peers in
      self.availablePeers = peers
    }
  }
}
