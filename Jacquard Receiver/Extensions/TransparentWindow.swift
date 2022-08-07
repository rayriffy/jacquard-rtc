//
//  TransparentWindow.swift
//  macOS
//
//  Created by Phumrapee Limpianchop on 2022/08/07.
//

import Foundation
import SwiftUI

class TransparentWindowView: NSView {
  override func viewDidMoveToWindow() {
    window?.backgroundColor = .clear
    super.viewDidMoveToWindow()
  }
}

struct TransparentWindow: NSViewRepresentable {
  func makeNSView(context: Self.Context) -> NSView { return TransparentWindowView() }
  func updateNSView(_ nsView: NSView, context: Context) { }
}
