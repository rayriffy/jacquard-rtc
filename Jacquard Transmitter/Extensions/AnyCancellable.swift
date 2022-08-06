//
//  AnyCancellable.swift
//  iOS
//
//  Created by Phumrapee Limpianchop on 2022/08/07.
//

import Foundation
import Combine

extension AnyCancellable {
  func addTo(_ array: inout [AnyCancellable]) {
    array.append(self)
  }
}
