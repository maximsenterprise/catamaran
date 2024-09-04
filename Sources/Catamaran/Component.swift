//
//  File.swift
//  
//
//  Created by Max Van den Eynde on 3/9/24.
//

import Foundation

/// Protocol that represents a UI element in a Catamaran Window.
///
/// A `Component` should have this methods:
///
/// ```swift
/// func render() -> Void
/// ```
///
/// And the following variables:
///
/// ```swift
/// var component_name: String { get }
/// var component_type: ComponentType { get }
/// ```
protocol Component {
    /// Variable that represents the name of the following Component that will be shown in the Console
    var component_name: String { get }
    /// Variable that represents the type of Component
    var component_type: ComponentType { get }
    
    /// Function that represents the lifetime of a Component. It will be runned every frame
    func render() -> Void
}

/// Enum that represents the different types of `Component` there are
enum ComponentType {
    case component
    case distantComponent
}

/// Protocol that represents a process that runs in a background or an application core
///
/// A `DistantComponent` should have this methods:
///
/// ```swift
/// func start() -> Void
/// optional func end() -> Void
/// ```
///
/// And the following variables:
///
/// ```swift
/// var component_name: String { get }
/// var component_type: ComponentType { get }
/// ```
protocol DistantComponent {
    var component_name: String { get }
    var component_type: ComponentType { get }
    func start() -> Void
    func end() -> Void
}

func execute(distant: any DistantComponent) -> Void {
    distant.start()
    distant.end()
}

extension DistantComponent {
    func end() {}
}
