//
//  OSLogger.swift
//
//  Created by Rodrigo Aparecido Morbach on 12/02/19.
//  Copyright © 2019 Rodrigo Aparecido Morbach. All rights reserved.
//

import Foundation
import os

public struct OSSystemLog {
    
    static var bundleIdentifier = Bundle.main.bundleIdentifier!
    
    static let `default` = OSSystemLog(withSubsystem: bundleIdentifier, category: OSSystemLog.Category.default)
    static let ui = OSSystemLog(withSubsystem: bundleIdentifier, category: OSSystemLog.Category.ui)
    static let network = OSSystemLog(withSubsystem: bundleIdentifier, category: OSSystemLog.Category.network)
    static let user = OSSystemLog(withSubsystem: bundleIdentifier, category: OSSystemLog.Category.user)
    
    let subsystem: String?
    let category: String
    
    init(withSubsystem subsystem: String? = nil, category: String) {
        self.subsystem = subsystem
        self.category = category
    }
    
    public enum Category {
        static let `default` = "Default"
        static let ui = "UI"
        static let network = "Network"
        static let coreData = "CoreData"
        static let user = "User"
    }
    
}

fileprivate extension OSSystemLog {
    func toOSLog() -> OSLog {
        guard let subsys = self.subsystem else {
            return OSLog.default
        }
        return OSLog(subsystem: subsys, category: self.category)
    }
}

public protocol OSLoggerProtocol {
    static func debug(_ message: StaticString, _ args: CVarArg...)
    static func debug(systemLog: OSSystemLog, _ message: StaticString, _ args: CVarArg...)
    
    static func info(_ message: StaticString, _ args: CVarArg...)
    static func info(systemLog: OSSystemLog, _ message: StaticString, _ args: CVarArg...)
    
    static func error(_ message: StaticString, _ args: CVarArg...)
    static func error(systemLog: OSSystemLog, _ message: StaticString, _ args: CVarArg...)
    
    static func fault(_ message: StaticString, _ args: CVarArg...)
    static func fault(systemLog: OSSystemLog, _ message: StaticString, _ args: CVarArg...)    
}

public class OSLogger: OSLoggerProtocol {
    
    private class func log(_ level: OSLogType = .default, _ message: StaticString, _ args: CVarArg...) {
        os_log(message, type: level, args)
    }
    
    private class func log(systemLog: OSSystemLog, level: OSLogType = .default, message: StaticString, args: CVarArg...) {
        os_log(level, log: systemLog.toOSLog(), message, args)
    }
    
    public class func debug(_ message: StaticString, _ args: CVarArg...) {
        log(.debug, message, args)
    }
    
    public class func debug(systemLog: OSSystemLog, _ message: StaticString, _ args: CVarArg...) {
        log(systemLog: systemLog, level: .debug, message: message, args: args)
    }
    
    public class func info(_ message: StaticString, _ args: CVarArg...) {
        log(.default, message, args)
    }
    
    public class func info(systemLog: OSSystemLog, _ message: StaticString, _ args: CVarArg...) {
        log(systemLog: systemLog, level: .info, message: message, args: args)
    }
    
    public class func error(_ message: StaticString, _ args: CVarArg...) {
        log(.error, message, args)
    }
    
    public class func error(systemLog: OSSystemLog, _ message: StaticString, _ args: CVarArg...) {
        log(systemLog: systemLog, level: .error, message: message, args: args)
    }
    
    public class func fault(_ message: StaticString, _ args: CVarArg...) {
        log(.fault, message, args)
    }
    
    public class func fault(systemLog: OSSystemLog, _ message: StaticString, _ args: CVarArg...) {
        log(systemLog: systemLog, level: .fault, message: message, args: args)
    }
    
}
