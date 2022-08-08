//
//  LiveActivity.swift
//  iOS
//
//  Created by Phumrapee Limpianchop on 2022/08/09.
//

import Foundation
import ActivityKit
import JacquardSDK

class LiveActivity: ObservableObject {
  @Published var liveActivityWidget: Activity<JacquardActivityAttributes>? = nil

  @Published var availablePeersCount: Int = 0
  @Published var selectedPeersCount: Int = 0
  @Published var gestureSentAmount: Int = 0
  @Published var lastGesture: String = ""
  
  @Published var lastGestureSentTime: Date = .now
  
  func update() async {
    do {
      try await liveActivityWidget?.update(using: .init(
        foundPeersCount: availablePeersCount,
        selectedPeersCount: selectedPeersCount,
        gesture: .init(
          lastGestureName: lastGesture,
          lastGestureSentTime: lastGestureSentTime,
          sentAmount: gestureSentAmount
        )
      ))
    } catch(let error) {
      print("failed to update live activity: \(error.localizedDescription)")
    }
  }

  init(jacquardTag: ConnectedTag) {
    let jacquardActivityAttributes = JacquardActivityAttributes(jacquardDisplayName: jacquardTag.displayName)
    let initialState = JacquardActivityAttributes.JacquardActivityStatus(
      foundPeersCount: 0,
      selectedPeersCount: 0,
      gesture: .init(lastGestureName: "", lastGestureSentTime: .now, sentAmount: 0)
    )

    do {
      let jacquardActivity = try Activity<JacquardActivityAttributes>.request(
        attributes: jacquardActivityAttributes,
        contentState: initialState,
        pushType: nil
      )
      
      self.liveActivityWidget = jacquardActivity
      print("live activity created: \(jacquardActivity.id)")
    } catch (let error) {
      print("failed requesting live activity: \(error.localizedDescription)")
    }
  }
}
