//
//  LastGesture.swift
//  Jacquard RTC
//
//  Created by Phumrapee Limpianchop on 2022/08/07.
//

import SwiftUI

struct LastGesture: View {
  @Binding var lastGestures: [String]
//  var prefixAmount: Int

  var body: some View {
    List {
      Section {
        ForEach(Array(lastGestures.reversed().enumerated()), id: \.offset) { index, lastGesture in
          HStack {
            Text(lastGesture)
            Spacer()
            Text("**#\(lastGestures.count - index)**")
          }
        }
      } header: {
        Text("Last Gesture")
      }
    }
  }
}
