//
//  SafeDecoding.swift
//  NearMe
//
//  Created by Eren Besel on 2019/08/21.
//  Copyright © 2019 Eren Besel. All rights reserved.
//

import Foundation

/// KeyedDecodingContainer extension for decoding with a default value.
extension KeyedDecodingContainer {
    
    /// Safely decodes value for given key if it's present otherwise returns default value
    ///
    /// - Parameters:
    ///   - key: Key for the value.
    ///   - defaultExpression: Default value to return if the value does not exists in container.
    /// - Returns: Value which is decodable type
    func decodeSafely<T: Decodable>(forKey key: Key, default defaultExpression: @autoclosure () -> T) throws -> T {
        return try decodeIfPresent(T.self, forKey: key) ?? defaultExpression()
    }
}
