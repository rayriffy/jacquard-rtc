//
//  Cancellable.swift
//  iOS
//
//  Created by Phumrapee Limpianchop on 2022/08/07.
//

import Foundation
import Combine

extension Cancellable {
  /// Provides a convenient way to retain Combine observation/Cancellables.
  ///
  /// example usage:
  /// ```
  /// class Foo {
  ///   private var observations = [Cancellable]()
  ///   func foo() {
  ///     somePublisher.sink({}).addTo(&observations)
  ///   }
  /// }
  /// ```
  func addTo(_ array: inout [Cancellable]) {
    array.append(self)
  }

  /// Provides a convenient way to retain Combine observation/AnyCancellable.
  ///
  /// example usage:
  /// ```
  /// class Foo {
  ///   private var observations = [AnyCancellable]()
  ///   func foo() {
  ///     somePublisher.sink({}).addTo(&observations)
  ///   }
  /// }
  /// ```
  func addTo(_ array: inout [AnyCancellable]) {
    if let self = self as? AnyCancellable {
      array.append(self)
    }
  }
}
