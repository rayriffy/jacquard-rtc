//
//  GestureInputView.swift
//  macOS
//
//  Created by Phumrapee Limpianchop on 2022/08/07.
//

import SwiftUI

struct GestureInputView: View {
  @State private var isListenForKeyChange: Bool = false
  
  func keyDown(with event: NSEvent) {
    print("event")
  }

  var body: some View {
    HStack {
      Text("Brush Out").padding(.trailing, 6)
      Button(action: {
        isListenForKeyChange.toggle()
      }, label: {
        Text(isListenForKeyChange ? "Listening for key" : "Example").frame(width: 150)
      })
    }
  }
}
