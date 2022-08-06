//
//  ContentView.swift
//  Jacquard RTC
//
//  Created by Phumrapee Limpianchop on 2022/08/02.
//

import Combine
import JacquardSDK
import SwiftUI

struct ContentView: View {
  @State private var jacquardTags: [AnyCancellable] = []
  @State private var isPageTransition: Bool = false
  @State private var selectedTagUUID: UUID = .init()

  @StateObject var jacquardScanner = JacquardTagScanner()

  var body: some View {
    NavigationStack {
      VStack {
        List {
          Section {
            ForEach($jacquardScanner.preConnectedTags, id: \.self.identifier) {
              $advertisedTag in
              NavigationLink(advertisedTag.displayName, value: advertisedTag.identifier)
            }
          } header: {
            Text("Connected tags")
          }
          Section {
            ForEach($jacquardScanner.advertisedTags, id: \.self.identifier) {
              $advertisedTag in
              NavigationLink(advertisedTag.displayName, value: advertisedTag.identifier)
            }
          } header: {
            Text("Discovered tags")
          }
        }
        .navigationTitle("Jacquard tags")
        .navigationDestination(for: UUID.self) { uuid in
          ConnectingView(manager: jacquardScanner.jacquardManager, tagId: uuid)
        }
      }
    }
  }
}
