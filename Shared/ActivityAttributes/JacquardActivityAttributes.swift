//
//  JacquardActivityAttributes.swift
//  Jacquard RTC
//
//  Created by Phumrapee Limpianchop on 2022/08/09.
//

import Foundation
import ActivityKit

struct JacquardActivityAttributes: ActivityAttributes {
  public typealias JacquardActivityStatus = ContentState
  
  public struct GestureActivity: Codable, Hashable {
    var lastGestureName: String
    var lastGestureSentTime: Date
    var sentAmount: Int
  }

  public struct ContentState: Codable, Hashable {
    var foundPeersCount: Int
    var selectedPeersCount: Int
    var gesture: GestureActivity
  }

  var jacquardDisplayName: String
}
