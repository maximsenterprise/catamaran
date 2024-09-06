//
//  Window.swift
//
//
//  Created by Max Van den Eynde on 3/9/24.
//

import Foundation

public class Window {
    let name: String
    public init(name: String) {
        self.name = name
        defer {
            set_component()
        }
    }
    
    private func set_component() {
        component = FrameComponent(name: name, parent: self)
    }
    
    public func show() {
        execute(distant: component!)
    }
    
    var component: FrameComponent? = nil
}
