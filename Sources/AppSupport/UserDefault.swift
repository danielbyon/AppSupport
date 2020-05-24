//
//  UserDefault.swift
//  AppSupport
//
//  Copyright © 2020 Daniel Byon
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation

@propertyWrapper
public struct UserDefault<Value> where Value: UserDefaultPersistable {

    public let key: String
    public let defaultValue: Value
    public let userDefaults: UserDefaults

    public static var userDefaults: UserDefaults = .standard

    public var wrappedValue: Value {
        get {
            guard let data = userDefaults.data(forKey: key) else { return defaultValue }
            do {
                return try PropertyListDecoder().decode(Value.self, from: data)
            } catch {
                return defaultValue
            }
        }
        set {
            let data = try? PropertyListEncoder().encode(newValue)
            userDefaults.set(data, forKey: key)
        }
    }

    public init(key: String, defaultValue: Value, userDefaults: UserDefaults = Self.userDefaults) {
        self.key = key
        self.defaultValue = defaultValue
        self.userDefaults = userDefaults
    }

}

public protocol UserDefaultPersistable: Codable { }

extension Array: UserDefaultPersistable where Self.Element: UserDefaultPersistable { }

#if os(iOS) || os(macOS)

import CoreGraphics
extension CGFloat: UserDefaultPersistable { }

#endif

extension Data: UserDefaultPersistable { }

extension Date: UserDefaultPersistable { }

extension Dictionary: UserDefaultPersistable where Self.Key: UserDefaultPersistable, Self.Value: UserDefaultPersistable { }

extension Double: UserDefaultPersistable { }

extension Float: UserDefaultPersistable { }

extension Int: UserDefaultPersistable { }
