//
//  Optional+Binding.swift
//  Reminders
//
//  Created by ANDREY VORONTSOV on 15.03.2023.
//

import Foundation

extension Optional where Wrapped == String {
    var _bound: String? {
        get {
            return self
        }
        set {
            self = newValue
        }
    }
    public var bound: String {
        get {
            return _bound ?? ""
        }
        set {
            _bound = newValue.isEmpty ? nil : newValue
        }
    }
}

extension Optional where Wrapped == Date {
    var _bound: Date? {
        get {
            return self
        }
        set {
            self = newValue
        }
    }
    public var bound: Date {
        get {
            return _bound ?? Date()
        }
        set {
            _bound = newValue
        }
    }
}

// or maybe like that:
/*
 func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
     Binding(
         get: { lhs.wrappedValue ?? rhs },
         set: { lhs.wrappedValue = $0 }
     )
 }
 */
