//
//  AppDelegate.swift
//  macOS
//
//  Created by Phumrapee Limpianchop on 2022/08/07.
//

import Foundation
import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
  func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }
}
