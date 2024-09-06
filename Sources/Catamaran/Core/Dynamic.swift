//
//  Dynamic.swift
//
//
//  Created by Max Van den Eynde on 5/9/24.
//

import Foundation

@propertyWrapper
public struct Dynamic<Value> {
    private var value: Value
    private let didSet: (Value) -> Void = { (Value) -> Void in
        Application.render_current()
    }
    
    public init(wrappedValue: Value) {
        self.value = wrappedValue
    }
    
    public var wrappedValue: Value {
        get { value }
        set {
            value = newValue
            didSet(newValue)
        }
    }
}
