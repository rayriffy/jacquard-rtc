//
//  ContentView.swift
//  Jacquard Receiver
//
//  Created by Phumrapee Limpianchop on 2022/08/06.
//

import SwiftUI
import MultipeerKit

struct ContentView: View {
  let transceiver = MultipeerTransceiver(configuration: MultipeerConfiguration(
    serviceType: "JacquardRTC",
    peerName: "Receiver - macOS",
    defaults: .standard,
    security: .default,
    invitation: .automatic
  ))

  var body: some View {
    VStack {
      Form {
//        KeyboardShortcuts.Recorder("Brush Out", name: .brushOut)
//        KeyboardShortcuts.Recorder("Brush In", name: .brushIn)
//        KeyboardShortcuts.Recorder("Double Tap", name: .doubleTap)
//        KeyboardShortcuts.Recorder("Cover", name: .cover)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .task {
      transceiver.resume()
      
//      transceiver.receive(TransmitterPayload.self) { payload, sender in
//        print("recieved \(payload.gesture) from (\(sender.name))[\(sender.id)]")
//      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
