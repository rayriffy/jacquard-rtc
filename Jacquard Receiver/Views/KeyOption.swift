//
//  KeyOption.swift
//  macOS
//
//  Created by Phumrapee Limpianchop on 2022/08/09.
//

import SwiftUI
import Algorithms

struct KeyOption: View {
  @EnvironmentObject var gestureKeyboard: GestureKeyboard

  var label: String
  var value: KeyboardKey

  var body: some View {
    let keyCombo = [
      gestureKeyboard.modifierControl ? "^" : nil,
      gestureKeyboard.modifierOption ? "⌥" : nil,
      gestureKeyboard.modifierShift ? "⇧" : nil,
      gestureKeyboard.modifierCommand ? "⌘" : nil,
    ].compacted()

    Text("\(keyCombo.joined())\(keyCombo.count != 0 ? " " : "")\(label)").tag(value)
  }
}
