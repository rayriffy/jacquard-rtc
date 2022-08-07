//
//  Jacquard_ReceiverApp.swift
//  Jacquard Receiver
//
//  Created by Phumrapee Limpianchop on 2022/08/06.
//

import SwiftUI

@main
struct Jacquard_ReceiverApp: App {
  @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    .windowStyle(.hiddenTitleBar)
  }
}
