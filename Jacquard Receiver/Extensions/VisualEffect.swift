//
//  VisualEffect.swift
//  iOS
//
//  Created by Phumrapee Limpianchop on 2022/08/07.
//

import SwiftUI
import Foundation

struct VisualEffect: NSViewRepresentable {
  func makeNSView(context: Self.Context) -> NSView { return NSVisualEffectView() }
  func updateNSView(_ nsView: NSView, context: Context) { }
}
