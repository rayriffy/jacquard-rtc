//
//  JacquardTagScanner.swift
//  Jacquard RTC
//
//  Created by Phumrapee Limpianchop on 2022/08/02.
//

import Foundation
import Combine
import JacquardSDK
import CoreBluetooth

extension AnyCancellable {
    func addTo(_ array: inout [AnyCancellable]) {
      array.append(self)
    }
}

class JacquardTagScanner: ObservableObject {
    @Published var preConnectedTags: [PreConnectedTag] = []
    @Published var advertisedTags: [AdvertisedTag] = []
    @Published var observations: [AnyCancellable] = []
    
    let jacquardManager: JacquardManager = JacquardManagerImplementation(
        options: [CBCentralManagerOptionRestoreIdentifierKey: "riffy-jacquardrtc-state"],
        config: SDKConfig(
            apiKey: "AIzaSyA5mkMfJ6eWmIf54Cy2kpXZf487P3g-9D8"
        )
    )
    
    init () {
        jacquardManager.advertisingTags.sink {
            [weak self] advertisedTag in
            print("found jacquard tag \(advertisedTag.displayName)")
            
            guard let self = self else { return }
            self.advertisedTags.append(advertisedTag)
        }.addTo(&observations)
        
        jacquardManager.centralState.sink {
            [weak self] state in
            switch (state) {
            case .poweredOn:
                guard let self = self else { return }

                self.preConnectedTags = self.jacquardManager.preConnectedTags()
                try! self.jacquardManager.startScanning(options: [:])
                print("scanning")
            default:
                break
            }
        }.addTo(&observations)
    }
}
