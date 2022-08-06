//
//  JacquardManager.swift
//  Jacquard RTC
//
//  Created by Phumrapee Limpianchop on 2022/08/06.
//

import Foundation
import JacquardSDK

extension JacquardManager {
  func asyncConnect(_ identifier: UUID) -> AsyncThrowingStream<TagConnectionState, Error> {
    AsyncThrowingStream { continuation in
      let cancellable = self.connect(identifier)
        .sink { completion in
          switch completion {
          case .finished:
            continuation.finish()
          case let .failure(error):
            continuation.finish(throwing: error)
          }
        } receiveValue: { connectionState in
          continuation.yield(connectionState)
        }

      continuation.onTermination = { @Sendable _ in
        cancellable.cancel()
      }
    }
  }
}
