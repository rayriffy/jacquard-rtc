//
//  Logger.swift
//  Jacquard RTC
//
//  Created by Phumrapee Limpianchop on 2022/08/02.
//

import Foundation

public func debug(_ category: String, _ message: String, file: String = #fileID, line: Int = #line, function: String = #function) {
    // ignore
}

public func log(_ category: String, _ message: String, file: String = #fileID, line: Int = #line, function: String = #function) {
    print("[\(category)][\(file):\(line)](\(function)) \(message)")
}
