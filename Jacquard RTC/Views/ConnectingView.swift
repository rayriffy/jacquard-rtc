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
    @Binding var jacquardTagId: UUID
    @Binding var jacquardManager: JacquardManager
    
    private var connectionStream: AnyPublisher<TagConnectionState, Never>?

    init(manager: Binding<JacquardManager>, tagId: Binding<UUID>) {
        self._jacquardTagId = tagId
        self._jacquardManager = manager

        // perform actions to connect to jacquard tag
        connectionStream = jacquardManager
            .connect(jacquardTagId)
            .catch { error -> AnyPublisher<TagConnectionState, Never> in
                // The only error that can happen here is TagConnectionError.bluetoothDeviceNotFound
                switch error as? TagConnectionError {
                case .bluetoothDeviceNotFound:
                    assertionFailure("CoreBluetooth couldn't find known tag for identifier \(jacquardTagId).")
                    return Just<TagConnectionState>(.disconnected(error)).eraseToAnyPublisher()
                default:
                    preconditionFailure("Unexpected error: \(error)")
                }
            }.eraseToAnyPublisher()
        
        // monitor connection state
        let tagOrNilPublisher = connectionStream?.map {
            state -> ConnectedTag? in
              if case .connected(let tag) = state {
                return tag
              }
              return nil
        }.removeDuplicates {
            previousState, currentState in
                if previousState == nil && currentState == nil {
                  return true
                }
                return false
        }
    }

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ConnectingView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectingView()
    }
}
