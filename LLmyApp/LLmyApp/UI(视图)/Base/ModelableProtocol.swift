//
//  ModelableProtocol.swift
//  LLmyApp
//
//  Created by chenyaolin on 2018/11/9.
//  Copyright © 2018年 LinChen. All rights reserved.
//

import UIKit

struct BaseModel: Modelable {
    
}

protocol Modelable: Codable {
    
}

extension Array: Modelable where Element: Modelable {
    
}

public extension KeyedDecodingContainer {
    
    public func decodeIfPresent(_ type: String.Type, forKey key: K) throws -> String? {
        
        if let stringValue = try? decode(String.self, forKey: key) {
            return stringValue
        } else if let intValue = try? decode(Int.self, forKey: key) {
            return "\(intValue)"
        } else if let doubleValue = try? decode(Double.self, forKey: key) {
            return "\(doubleValue)"
        }
        
        return nil
    }
    
    public func decodeIfPresent(_ type: Bool.Type, forKey key: K) throws -> Bool? {
        if let boolValue = try? decode(Bool.self, forKey: key) {
            return boolValue
        } else if let intValue = try? decode(Int.self, forKey: key) {
            return intValue != 0
        }
        return nil
    }
    
    public func decodeIfPresent(_ type: Int.Type, forKey key: K) throws -> Int? {
        
        if let intValue = try? decode(Int.self, forKey: key) {
            return intValue
        } else if let stringValue = try? decode(String.self, forKey: key) {
            return Int(stringValue)
        } else if let doubleValue = try? decode(Double.self, forKey: key) {
            return Int(doubleValue)
        }
        
        return nil
    }
    
    public func decodeIfPresent(_ type: Double.Type, forKey key: K) throws -> Double? {
        if let doubleValue = try? decode(Double.self, forKey: key) {
            return doubleValue
        } else if let intValue = try? decode(Int.self, forKey: key) {
            return Double(intValue)
        } else if let stringValue = try? decode(String.self, forKey: key) {
            return Double(stringValue)
        }
        
        return nil
    }
    
    public func decodeIfPresent(_ type: UInt.Type, forKey key: K) throws -> UInt? {
        return try? decode(type.self, forKey: key)
    }
    
    public func decodeIfPresent(_ type: Int8.Type, forKey key: K) throws -> Int8? {
        return try? decode(type.self, forKey: key)
    }
    
    public func decodeIfPresent(_ type: Float.Type, forKey key: K) throws -> Float? {
        return try? decode(type.self, forKey: key)
    }
    
    public func decodeIfPresent(_ type: Int16.Type, forKey key: K) throws -> Int16? {
        return try? decode(type.self, forKey: key)
    }
    
    public func decodeIfPresent(_ type: Int32.Type, forKey key: K) throws -> Int32? {
        return try? decode(type.self, forKey: key)
    }
    
    public func decodeIfPresent(_ type: Int64.Type, forKey key: K) throws -> Int64? {
        return try? decode(type.self, forKey: key)
    }
    
    public func decodeIfPresent(_ type: UInt8.Type, forKey key: K) throws -> UInt8? {
        return try? decode(type.self, forKey: key)
    }
    
    public func decodeIfPresent(_ type: UInt16.Type, forKey key: K) throws -> UInt16? {
        return try? decode(type.self, forKey: key)
    }
    
    public func decodeIfPresent(_ type: UInt32.Type, forKey key: K) throws -> UInt32? {
        return try? decode(type.self, forKey: key)
    }
    
    public func decodeIfPresent<T>(_ type: T.Type, forKey key: K) throws -> T? where T: Decodable {
        return try? decode(type.self, forKey: key)
    }
}
