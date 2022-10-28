//
//  LiveActivity.swift
//  Jacquard WidgetsExtension
//
//  Created by Phumrapee Limpianchop on 2022/08/09.
//

import SwiftUI
import ActivityKit
import WidgetKit

struct JacquardActivityWidget: Widget {
  var body: some WidgetConfiguration {
    ActivityConfiguration(for: JacquardActivityAttributes.self) {
      context in
      VStack(alignment: .leading) {
        HStack(alignment: .center) {
          VStack(alignment: .leading) {
            Text(context.attributes.jacquardDisplayName).bold().font(.system(size: 18))
            
            HStack {
              VStack(alignment: .leading) {
                Text("Last gesture").font(.footnote)
                Text(context.state.gesture.lastGestureName)
              }
              VStack {
                Text("\(context.state.gesture.sentAmount) 👋🏻").foregroundColor(.white).font(.headline).padding(4).background(.blue).cornerRadius(6)
              }.padding(.leading)
            }
          }
          .padding(.vertical, 4)
          Spacer()
          HStack {
            Text("\(context.state.selectedPeersCount) 📡").font(.title).bold()
            Text("\(context.state.foundPeersCount) 💻").font(.title).bold()
          }
        }
        HStack {
          Text(context.state.gesture.lastGestureSentTime, style: .relative)
            .font(.caption)
            .foregroundColor(.secondary)
          + Text(" since last gesture sent")
            .font(.caption)
            .foregroundColor(.secondary)
          
        }
      }.padding(20)
    } dynamicIsland: { context in
      DynamicIsland {
        DynamicIslandExpandedRegion(.leading) {
            Text("amogus")
        }
      } compactLeading: {
        Text("👋🏻 \(context.state.gesture.sentAmount)")
      } compactTrailing: {
        Text("\(context.state.selectedPeersCount) 📡")
      } minimal: {
        VStack(alignment: .center) {
          Text("📡")
        }
      }
    }
  }
}
