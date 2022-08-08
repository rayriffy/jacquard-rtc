//
//  ConnectingView.swift
//  Jacquard Transmitter
//
//  Created by Phumrapee Limpianchop on 2022/08/02.
//

import Combine
import JacquardSDK
import SwiftUI

struct ConnectingView: View {
  @State private var connectedTag: ConnectedTag? = nil
  @State private var lastConnectionStateDescription = "Preparing to connect..."
  
  private var tagIdentifier: UUID
  private var jacquardManager: JacquardManager

  init (manager: JacquardManager, tagId: UUID) {
    self.tagIdentifier = tagId
    self.jacquardManager = manager
  }

  var body: some View {
    VStack {
      if connectedTag != nil {
        ControllerView(jacquardTag: $connectedTag)
      } else {
        Text(lastConnectionStateDescription)
      }
    }.task {
      do {
        // attempt tp connect to jacquard tag
        let connectionStream = jacquardManager.asyncConnect(tagIdentifier)
        for try await connectionState in connectionStream {
          print("connection state: \(connectionState)")
          switch connectionState {
          case .connected(let tag):
            connectedTag = tag
          default:
            connectedTag = nil
            lastConnectionStateDescription = "\(connectionState)"
          }
        }
      } catch {
        print("error during connection: \(error)")
      }
    }
  }
}
