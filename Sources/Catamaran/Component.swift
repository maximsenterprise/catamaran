//
//  File.swift
//  
//
//  Created by Max Van den Eynde on 3/9/24.
//

import Foundation
import Cocoa

/// Protocol that represents a UI element in a Catamaran Window.
///
/// A `Component` should have this methods:
///
/// ```swift
/// func render_linux() -> Void
/// func render_windows() -> Void
/// func render_macOS() -> NSView
/// ```

public protocol Component {
    /// Function that represents the lifetime of a Component. It will be runned every frame
    func render_linux(_ window: Window) -> Void
    func render_macOS(_ window: Window) -> NSView
    func render_windows(_ window: Window) -> Void
}

/// Enum that represents the different types of `Component` there are
public enum ComponentType {
    case component
    case distantComponent
    case predicateComponent
    case transientComponent
    case staticComponent
    
    case windowsComponent
    case linuxComponent
    case macComponent
}

/// Protocol that represents a UI element that runs only in macOS
///
/// A `MacComponent` should have this methods:
///
/// ```swift
/// func render() -> Void
/// ```
public protocol MacComponent: Component {
    
}

/// Protocol that represents a UI element that runs only in Linux
///
/// A `LinuxComponent` should have this methods:
///
/// ```swift
/// func render() -> Void
/// ```
public protocol LinuxComponent: Component {
    
}

/// Protocol that represents a UI element that runs only in Windows
///
/// A `WindowsComponent` should have this methods:
///
/// ```swift
/// func render() -> Void
/// ```
public protocol WindowsComponent: Component {
    
}

/// Protocol that represents a UI element that is render independently of the platform it runs.
///
/// A `StaticComponent` should have this methods:
///
/// ```swift
/// func render(_ window: Window) -> Void
/// ```
public protocol StaticComponent {
    func render(_ window: Window) -> Void
}

/// Protocol that represents a UI element which is displayed only once.
///
/// A `TransientComponent` should have this methods:
///
/// ```swift
/// func render_linux(_ window: Window) -> Void
/// func render_windows(_ window: Window) -> Void
/// func render_macOS(_ window: Window) -> NSView
/// func one_frame(_ window: Window) -> Void
/// ```
public protocol TransientComponent: Component {
    func one_frame(_ window: Window) -> Void
}

/// Protocol that represents a process that runs in a background or an application core
///
/// A `DistantComponent` should have this methods:
///
/// ```swift
/// func start() -> Void
/// optional func end() -> Void
/// ```
public protocol DistantComponent {
    func start() -> Void
    func end() -> Void
}

/// Protocol that represents a Component with only two states: `.on` and `.off`
///
/// A `PredicateComponent` should have this methods:
///
/// ```swift
/// func render_linux(_ window: Window) -> Void
/// func render_windows(_ window: Window) -> Void
/// func render_macOS(_ window: Window) -> NSView
/// ```
///
/// And the following variables:
///
/// ```swift
/// var result: PredicateResult { get }
/// ```
public protocol PredicateComponent: Component {
    var result: PredicateResult { get }
    func isOn() -> Bool
    func isOff() -> Bool
}

public extension PredicateComponent {
    func isOn() -> Bool {
        return result == .on
    }
    
    func isOff() -> Bool {
        return result == .off
    }
}

/// A enum that represents all the possible states of a `PredicateComponent`
public enum PredicateResult {
    case on
    case off
}

/// Function to execute a `DistantComponent` correctly
public func execute(distant: any DistantComponent) -> Void {
    distant.start()
    distant.end()
}

public extension DistantComponent {
    func end() {}
}
