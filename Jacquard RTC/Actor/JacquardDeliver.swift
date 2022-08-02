//
//  JacquardDeliver.swift
//  Jacquard RTC
//
//  Created by Phumrapee Limpianchop on 2022/08/02.
//

// Definition of actor to send, and recieve jacquard gestures

import Foundation
import Distributed

import JacquardSDK

//public typealias RTCReciver =

public protocol DeliverSkeleton: DistributedActor, Codable where ID == ActorIdentity {
    // function to be called to send gesture to network
    func onSend() async throws -> Gesture
    
    func onRecieve(_ gesture: Gesture) async throws
}

public distributed actor JacquardDeliver: DeliverSkeleton {
    public typealias ActorSystem = LocalNetworkActorSystem

    let actAs: JacquardAct

    public init(actAs: JacquardAct, actorSystem: ActorSystem) {
        self.actAs = actAs
        self.actorSystem = actorSystem
    }
    
    public distributed func onSend() async -> Gesture {
        return gesture
    }
}
