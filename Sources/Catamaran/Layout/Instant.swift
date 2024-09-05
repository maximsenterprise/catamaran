//
//  File.swift
//  
//
//  Created by Max Van den Eynde on 4/9/24.
//

import Cocoa
import SwiftUI

public struct Instant: Component {
    
    @ComponentBuilder public var content: () -> [any Component]
    
    public init(@ComponentBuilder content: @escaping () -> [any Component]) {
        self.content = content
    }
    
    public func render_linux(_ window: Window) {
        
    }
    
    public func render_macOS(_ window: Window) -> NSView {
        var views: [NSView] = []
        for component in content() {
            views.append(component.render_macOS(window))
        }
        let stackView = NSStackView(views: views)
        stackView.orientation = .vertical
        stackView.spacing = 10
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }
    
    public static subscript(_ content: any Component...) -> [any Component] {
        return content
    }
    
    public func render_windows(_ window: Window) {
        
    }
    
    public var component_name: String = "Instant"
    public var component_type: ComponentType = .component
}

@resultBuilder
public struct ComponentBuilder {
    public static func buildBlock(_ components: [any Component]...) -> [any Component] {
        components.flatMap { $0 }
    }
    
    public static func buildExpression(_ expression: any Component) -> [any Component] {
        [expression]
    }
    
    public static func buildOptional(_ component: [any Component]?) -> [any Component] {
        component ?? []
    }
    
    public static func buildEither(first component: [any Component]) -> [any Component] {
        component
    }
    
    public static func buildEither(second component: [any Component]) -> [any Component] {
        component
    }
}

public struct Row: Component {
    
    @ComponentBuilder public var content: () -> [any Component]
    
    public init(@ComponentBuilder content: @escaping () -> [any Component]) {
        self.content = content
    }
    
    public func render_linux(_ window: Window) {
        
    }
    
    public func render_macOS(_ window: Window) -> NSView {
        var views: [NSView] = []
        for component in content() {
            views.append(component.render_macOS(window))
        }
        let stackView = NSStackView(views: views)
        stackView.orientation = .horizontal
        stackView.spacing = 10
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }
    
    public static subscript(_ content: any Component...) -> [any Component] {
        return content
    }
    
    public func render_windows(_ window: Window) {
        
    }
    
    public var component_name: String = "Row"
    public var component_type: ComponentType = .component
}

public typealias Column = Instant
