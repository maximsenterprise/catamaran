//
//  File.swift
//  
//
//  Created by Max Van den Eynde on 6/9/24.
//

import Foundation
import SwiftUI

@MacComponent
public struct ToolbarComponent {
    @ComponentBuilder var content: () -> [any Component]
    public func render_macOS(_ window: Window) -> NSView {
        return NSView(frame: NSRect(x: 1, y: 1, width: 20, height: 20))
    }
    
    public init(@ComponentBuilder content: @escaping () -> [any Component]) {
        #if !os(macOS)
        #warning("This Component will not be shown since it's a macOS only Component")
        #endif
        self.content = content
    }
    
    public static subscript(_ content: any Component...) -> [any Component] {
        return content
    }
    
    public func render_linux(_ window: Window) {
        
    }
    
    public func render_windows(_ window: Window) {
        
    }
}
