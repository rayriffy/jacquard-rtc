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

  @State private var gestureBrushOutKey: KeyboardKey = KeyboardKey.key_arrowRight
  @State private var gestureBrushInKey: KeyboardKey = KeyboardKey.key_arrowLeft
  @State private var gestureDoubleTapKey: KeyboardKey = KeyboardKey.key_space
  @State private var gestureCoverKey: KeyboardKey = KeyboardKey.key_esc

  let transceiver = MultipeerTransceiver(configuration: MultipeerConfiguration(
    serviceType: "JacquardRTC",
    peerName: "Receiver - macOS",
    defaults: .standard,
    security: .default,
    invitation: .automatic
  ))

  func pressKeyboard(key: KeyboardKey) {
    let keyCode: UInt16 = key.rawValue
    let keyDownEvent = CGEvent(keyboardEventSource: nil, virtualKey: keyCode, keyDown: true)
    keyDownEvent?.post(tap: CGEventTapLocation.cghidEventTap)

    let keyUpEvent = CGEvent(keyboardEventSource: nil, virtualKey: keyCode, keyDown: false)
    keyUpEvent?.post(tap: CGEventTapLocation.cghidEventTap)
  }

  var body: some View {
    VStack {
      Text("**\(dataSource?.availablePeers.count ?? -1) 💻**").font(.system(size: 32))
      Text("Ready to receive").padding().dynamicTypeSize(.medium)
      
      Form {
        KeyboardPicker(label: "Brush Out", selection: $gestureBrushOutKey)
        KeyboardPicker(label: "Brush In", selection: $gestureBrushInKey)
        KeyboardPicker(label: "Double Tap", selection: $gestureDoubleTapKey)
        KeyboardPicker(label: "Cover", selection: $gestureCoverKey)
      }
      
      List {
        Section {
          ForEach(lastGestures.reversed().prefix(12), id: \.self) { lastGesture in
            Text(lastGesture)
          }
        } header: {
          Text("Last Gesture")
        }
      }
    }
    .padding(20)
    .frame(width: 400, height: 600)
    .background(.white)
    .task {
      transceiver.resume()
      
      transceiver.receive(TransmitterPayload.self) { payload, sender in
        print("recieved \(payload.gesture) from (\(sender.name))[\(sender.id)]")
        self.lastGestures.append(payload.gesture)

        switch (payload.gesture) {
        case "Brush Out":
          pressKeyboard(key: gestureBrushOutKey)
          break
        case "Brush In":
          pressKeyboard(key: gestureBrushInKey)
          break
        case "Double Tap":
          pressKeyboard(key: gestureDoubleTapKey)
          break
        case "Cover":
          pressKeyboard(key: gestureCoverKey)
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
