//
//  GestureKeyboard.swift
//  macOS
//
//  Created by Phumrapee Limpianchop on 2022/08/07.
//

import Foundation
import SwiftUI

class GestureKeyboard: ObservableObject {
  @Published var keyboardKey: KeyboardKey

  @Published var modifierCommand: Bool = false
  @Published var modifierOption: Bool = false
  @Published var modifierControl: Bool = false
  @Published var modifierShift: Bool = false

  init(keyboardKey: KeyboardKey) {
    self.keyboardKey = keyboardKey
  }
  
  func execute() {
    let keyCode: UInt16 = keyboardKey.rawValue

    // calculate mask CGEventFlags
    var mask: CGEventFlags = []
    if (modifierCommand == true) {
      mask.insert(CGEventFlags.maskCommand)
    }
    if (modifierOption == true) {
      mask.insert(CGEventFlags.maskAlternate)
    }
    if (modifierControl == true) {
      mask.insert(CGEventFlags.maskControl)
    }
    if (modifierShift == true) {
      mask.insert(CGEventFlags.maskShift)
    }

    // build and send keyDown event
    let keyDownEvent = CGEvent(keyboardEventSource: nil, virtualKey: keyCode, keyDown: true)
    if (mask.rawValue != 0) {
      keyDownEvent?.flags = mask
    }
    keyDownEvent?.post(tap: CGEventTapLocation.cghidEventTap)

    // build and send keyUp event
    let keyUpEvent = CGEvent(keyboardEventSource: nil, virtualKey: keyCode, keyDown: false)
    if (mask.rawValue != 0) {
      keyUpEvent?.flags = mask
    }
    keyUpEvent?.post(tap: CGEventTapLocation.cghidEventTap)
  }
}
