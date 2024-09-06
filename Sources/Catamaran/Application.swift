//
//  File.swift
//  
//
//  Created by Max Van den Eynde on 4/9/24.
//

import Foundation

public typealias RenderReference = (_ window: Window) -> Any

public class Application {
    static var window: Window? = nil
    static var queue: [RenderReference] = []
    static var current_component: Component? = nil
    
    public static func attach_window(_ window: Window) {
        self.window = window
    }
    
    public static func render_at(stage: ApplicationStage, component: Component) {
        self.current_component = component
        if (stage == .overlay) {
            #if os(macOS)
            if let window = window {
                window.component?.window?.contentView = component.render_macOS(window)
            } else {
                fatalError("Window is not present in Application, thus cannot be overlayed")
            }
            #endif
            return
        }
        #if os(macOS)
        queue.append(component.render_macOS)
        #elseif os(Linux)
        queue.append(component.render_linux)
        #else
        queue.append(component.render_windows)
        #endif
    }
    
    public static func render_current() {
        #if os(macOS)
        if let current_component = current_component {} else {
            fatalError("CurrentComponent is null")
        }
        if let window = window {
            window.component?.window?.contentView = current_component?.render_macOS(window)
        }
        #endif
    }
    
    public static func begin() {
        if let window = window {
            window.show()
        } else {
            fatalError("Window is not present in Application, thus it cannot be showed")
        }
    }
}

public enum ApplicationStage {
    case window
    case overlay
}
