//
//  ConnectingView.swift
//  Jacquard RTC
//
//  Created by Phumrapee Limpianchop on 2022/08/02.
//

import SwiftUI
import Combine
import JacquardSDK

struct ConnectingView: View {
    @State private var connectedTag: ConnectedTag? = nil
    @State private var isPageTransition: Bool = false
    
    private var connectionStream: AnyPublisher<TagConnectionState, Never>?

    init(manager: JacquardManager, tagId: UUID) {
        // perform actions to connect to jacquard tag
        print("tag connect request")
        print(tagId)
        print(self.connectionStream)
        self.connectionStream = manager
            .connect(tagId)
            .catch { error -> AnyPublisher<TagConnectionState, Never> in
                // The only error that can happen here is TagConnectionError.bluetoothDeviceNotFound
                switch error as? TagConnectionError {
                case .bluetoothDeviceNotFound:
                  assertionFailure("CoreBluetooth couldn't find known tag for identifier \(tagId).")
                  return Just<TagConnectionState>(.disconnected(error)).eraseToAnyPublisher()
                default:
                  preconditionFailure("Unexpected error: \(error)")
                }
              }
            .eraseToAnyPublisher()
        
        // monitor connection state
        print("connectionStream")
        print(self.connectionStream)

        let tagOrNilPublisher = self.connectionStream?.map {
            [self] state -> ConnectedTag? in
                print("state update: ")
                print(state)
              if case .connected(let tag) = state {
                  print("tag connected")
                  self.connectedTag = tag
                  self.isPageTransition = true
                  return tag
              }
              return nil
        }.removeDuplicates {
            previousState, currentState in
                if previousState == nil && currentState == nil {
                    print("duplicates removed")
                  return true
                }
                return false
        }
    }

    var body: some View {
        VStack {
            Text("Connecting...")

//            NavigationLink(destination: ControllerView(
//                jacquardTag: connectedTag
//            ), isActive: $isPageTransition) { EmptyView() }
        }
    }
}
