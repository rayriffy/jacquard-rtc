//
//  ContentView.swift
//  Jacquard Receiver
//
//  Created by Phumrapee Limpianchop on 2022/08/06.
//

import SwiftUI
import MultipeerKit

struct ContentView: View {
  @State private var dataSource: MultipeerDataSource? = nil
  @State private var lastGestures: [String] = []
  @State private var selectedPeers: [Peer] = []
  
  @StateObject var gestureBrushOut: GestureKeyboard = GestureKeyboard(keyboardKey: KeyboardKey.key_arrowRight)
  @StateObject var gestureBrushIn: GestureKeyboard = GestureKeyboard(keyboardKey: KeyboardKey.key_arrowLeft)
  @StateObject var gestureDoubleTap: GestureKeyboard = GestureKeyboard(keyboardKey: KeyboardKey.key_space)
  @StateObject var gestureCover: GestureKeyboard = GestureKeyboard(keyboardKey: KeyboardKey.key_esc)

  let transceiver = MultipeerTransceiver(configuration: MultipeerConfiguration(
    serviceType: "JacquardRTC",
    peerName: "Receiver - macOS",
    defaults: .standard,
    security: .default,
    invitation: .automatic
  ))

  var body: some View {
    VStack {
      Text("**\(dataSource?.availablePeers.count ?? -1) 💻**")
        .font(.system(size: 32))
        .padding(.top, 14)
      Text("Ready to receive")
        .padding()
        .dynamicTypeSize(.medium)
      
      Form {
        SettingPanelView(label: "Brush Out", gestureKeyboard: gestureBrushOut)
        SettingPanelView(label: "Brush In", gestureKeyboard: gestureBrushIn)
        SettingPanelView(label: "Double Tap", gestureKeyboard: gestureDoubleTap)
        SettingPanelView(label: "Cover", gestureKeyboard: gestureCover)
      }
      
      List {
        Section {
//          ForEach((1...11).reversed(), id: \.self) {
//            Text("Gesture \($0)")
//          }
          ForEach(lastGestures.reversed().prefix(11), id: \.self) { lastGesture in
            Text(lastGesture)
          }
        } header: {
          Text("Last Gesture")
        }
      }
      List {
        ForEach(dataSource?.availablePeers) { peer in
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
    .padding(20)
    .frame(width: 400, height: 600)
    .background(VisualEffect().ignoresSafeArea())
    .task {
      // start multipeer
      transceiver.resume()

      // observe datasource
      self.dataSource = MultipeerDataSource(transceiver: transceiver)
      
      transceiver.receive(TransmitterPayload.self) { payload, sender in
        print("recieved \(payload.gesture) from (\(sender.name))[\(sender.id)]")
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

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
