//
//  SettingPanelView.swift
//  macOS
//
//  Created by Phumrapee Limpianchop on 2022/08/07.
//

import SwiftUI

struct SettingPanelView: View {
  var label: String
  @EnvironmentObject var gestureKeyboard: GestureKeyboard
  
  @State var isShowPopover = false

  var body: some View {
    HStack {
      KeyboardPicker(label: label, gestureKeyboard: gestureKeyboard)
      Button(action: {
        self.isShowPopover.toggle()
      }, label: {
        Image(systemName: "gear.circle.fill").font(.system(size: 18))
      })
      .buttonStyle(.borderless)
      .popover(
        isPresented: self.$isShowPopover,
        arrowEdge: .bottom,
        content: {
          HStack {
            Toggle("^", isOn: $gestureKeyboard.modifierControl).toggleStyle(.button)
            Toggle("⌥", isOn: $gestureKeyboard.modifierOption).toggleStyle(.button)
            Toggle("⇧", isOn: $gestureKeyboard.modifierShift).toggleStyle(.button)
            Toggle("⌘", isOn: $gestureKeyboard.modifierCommand).toggleStyle(.button)
          }.padding()
        }
      )
    }
  }
}
