//
//  ActorIdentity.swift
//  Jacquard RTC
//
//  Created by Phumrapee Limpianchop on 2022/08/02.
//

import Foundation

public struct ActorIdentity: Hashable, Sendable, Codable, CustomStringConvertible, CustomDebugStringConvertible {
  public let `protocol`: String?
  public let host: String?
  public let port: Int?
  public let id: String

  public init(id: String) {
    self.`protocol` = nil
    self.host = nil
    self.port = nil
    self.id = id
  }

  public init(protocol: String, host: String, port: Int, id: String) {
    self.`protocol` = `protocol`
    self.host = host
    self.port = port
    self.id = id
  }

  public static var random: Self {
        .init(id: "\(UUID().uuidString)")
    }

  public var description: String {
    if let proto = self.protocol,
       let host = self.host,
       let port = self.port {
      // full-details ID
      return "\(proto)://\(host):\(port)#\(id)"
    } else {
      // simple format ID
      return "\(id)"
    }
  }

  public var debugDescription: String {
    if let proto = self.protocol,
       let host = self.host,
       let port = self.port {
      // full-details ID
      return "Self.self(\(proto)://\(host):\(port)#\(self.description))"
    } else {
      // simple format ID
      return "\(Self.self)(\(self.description))"
    }
  }
}
