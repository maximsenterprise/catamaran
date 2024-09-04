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
        component = FrameComponent(name: name)
    }
    
    public func show() {
        execute(distant: component)
    }
    
    let component: FrameComponent
}
