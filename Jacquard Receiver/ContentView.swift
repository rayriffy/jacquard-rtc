//
//  ContentView.swift
//  Jacquard Receiver
//
//  Created by Phumrapee Limpianchop on 2022/08/06.
//

import SwiftUI
import MultipeerKit

struct ContentView: View {
  @State private var lastGestures: [String] = []
  
  @StateObject var peerSelector: PeerSelector = PeerSelector()
  @StateObject var multipeerDevices: MultipeerDevices = MultipeerDevices()
  
  @StateObject var gestureBrushOut: GestureKeyboard = GestureKeyboard(keyboardKey: KeyboardKey.key_arrowRight)
  @StateObject var gestureBrushIn: GestureKeyboard = GestureKeyboard(keyboardKey: KeyboardKey.key_arrowLeft)
  @StateObject var gestureDoubleTap: GestureKeyboard = GestureKeyboard(keyboardKey: KeyboardKey.key_space)
  @StateObject var gestureCover: GestureKeyboard = GestureKeyboard(keyboardKey: KeyboardKey.key_esc)

  var body: some View {
    VStack {
      Text("**\(multipeerDevices.availablePeers.count) 💻**")
        .font(.system(size: 32))
        .padding(.top, 14)
      Text("Ready to receive")
        .padding(.top)
        .dynamicTypeSize(.medium)
      Text("Your ID: \(String((multipeerDevices.transceiver!.localPeerId ?? "").prefix(8)))").dynamicTypeSize(.small)
      
      Form {
        SettingPanelView(label: "Brush Out", gestureKeyboard: gestureBrushOut)
        SettingPanelView(label: "Brush In", gestureKeyboard: gestureBrushIn)
        SettingPanelView(label: "Double Tap", gestureKeyboard: gestureDoubleTap)
        SettingPanelView(label: "Cover", gestureKeyboard: gestureCover)
      }
      
      
      MultipeerDevicesView(
        peerSelector: peerSelector,
        multipeerDevices: multipeerDevices
      )
      
      LastGesture(lastGestures: self.$lastGestures)
    }
    .padding(20)
    .frame(width: 400, height: 630)
    .background(VisualEffect().ignoresSafeArea())
    .task {
      // start multipeer
      multipeerDevices.transceiver!.resume()
      
      multipeerDevices.transceiver!.receive(TransmitterPayload.self) { payload, sender in
        // only recieve gesture from authorized device
        let selectedPeerIds = self.peerSelector.selectedPeers.map { $0.id }

        if (selectedPeerIds.contains(sender.id)) {
          self.lastGestures.append(payload.gesture)

          switch (payload.gesture) {
          case "Brush Out":
            gestureBrushOut.execute()
            break
          case "Brush In":
            gestureBrushIn.execute()
            break
          case "Double Tap":
            gestureDoubleTap.execute()
            break
          case "Cover":
            gestureCover.execute()
            break
          default:
            break
          }
        }
      }
    }
  }
}
