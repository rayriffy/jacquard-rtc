//
//  ContentView.swift
//  Jacquard RTC
//
//  Created by Phumrapee Limpianchop on 2022/08/02.
//

import SwiftUI
import Combine
import JacquardSDK

struct ContentView: View {
    @State private var jacquardTags: [AnyCancellable] = []

    let jacquardScanner = JacquardTagScanner()

    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach (jacquardScanner.preConnectedTags, id: \.self.identifier) {
                        advertisedTag in
                        Text(advertisedTag.displayName).padding()
                    }
                } header: {
                    Text("Connected tags")
                }
                Section {
                    ForEach (jacquardScanner.advertisedTags, id: \.self.identifier) {
                        advertisedTag in
                        Text(advertisedTag.displayName).padding()
                    }
                } header: {
                    Text("Discovered tags")
                }
            }.navigationTitle("Jacquard tags")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
