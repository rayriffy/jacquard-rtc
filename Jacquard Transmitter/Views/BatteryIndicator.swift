//
//  BatteryIndicator.swift
//  iOS
//
//  Created by Phumrapee Limpianchop on 2022/08/09.
//

import SwiftUI
import Combine
import JacquardSDK

struct BatteryIndicator: View {
  @Binding var jacquardTag: ConnectedTag?
  @Binding var observers: [Cancellable]
  
  @State private var batteryLevel: UInt32 = 0

  var body: some View {
    HStack {
      Image(
        systemName: "battery.\(batteryLevel <= 25 ? 25 : batteryLevel <= 50 ? 50 : batteryLevel <= 75 ? 75 : 100)"
      )
        .font(.system(size: 18))
        .symbolRenderingMode(.palette)
        .foregroundStyle(batteryLevel <= 25 ? .red : batteryLevel <= 50 ? .yellow : .green, .gray)
      Text("**\(batteryLevel)%**")
    }.task {
      jacquardTag?.registerSubscriptions { subscribableTag in
        // sink returns cancellable type, need to store somewhere because if it's destroy then it won't be called
        let batteryNotification = subscribableTag
          .subscribe(BatteryStatusNotificationSubscription())
          .sink {
            notification in

            print("battery level: \(notification.batteryLevel)%")
            self.batteryLevel = notification.batteryLevel
          }

        self.observers.append(batteryNotification)
      }
    }
  }
}
