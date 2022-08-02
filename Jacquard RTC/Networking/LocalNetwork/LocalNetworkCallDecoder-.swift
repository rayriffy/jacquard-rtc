//
//  LocalNetworkCallDecoder-.swift
//  Jacquard RTC
//
//  Created by Phumrapee Limpianchop on 2022/08/02.
//

// Decoder type that is used to decode remote calls.

import Foundation
import Distributed
import os
import Network

@available(iOS 16.0, *)
public class LocalNetworkCallDecoder: DistributedTargetInvocationDecoder {
    public typealias SerializationRequirement = Codable

    let decoder: JSONDecoder
    let envelope: RemoteCallEnvelope
    var argumentsIterator: Array<Data>.Iterator

    init(system: LocalNetworkActorSystem, envelope: RemoteCallEnvelope) {
        self.envelope = envelope
        self.argumentsIterator = envelope.args.makeIterator()

        let decoder = JSONDecoder()
        decoder.userInfo[.actorSystemKey] = system
        self.decoder = decoder
    }

    public  func decodeGenericSubstitutions() throws -> [Any.Type] {
        envelope.genericSubs.compactMap { name in
            _typeByName(name)
        }
    }

    public  func decodeNextArgument<Argument: Codable>() throws -> Argument {
        guard let data = argumentsIterator.next() else {
            throw LocalNetworkActorSystemError.notEnoughArgumentsInEnvelope(expected: Argument.self)
        }

        return try decoder.decode(Argument.self, from: data)
    }

    public func decodeErrorType() throws -> Any.Type? {
        nil // not encoded, ok
    }

    public func decodeReturnType() throws -> Any.Type? {
        nil // not encoded, ok
    }
}
