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
    private var width: Int? = nil
    private var height: Int? = nil
    
    public init(@ComponentBuilder content: @escaping () -> [any Component]) {
        self.content = content
    }
    
    public func render_linux(_ window: Window) {
        
    }
    
    func GetOpts() -> (Int, Int) {
        var finalWidth = -1
        var finalHeight = -1
        if let width = self.width {
            finalWidth = width
        }
        if let height = self.height {
            finalHeight = height
        }
        return (finalWidth, finalHeight)
    }
    
    public func render_macOS(_ window: Window) -> NSView {
        var views: [AnyNSViewRepresentable] = []
        for component in content() {
            views.append(AnyNSViewRepresentable(nsView: component.render_macOS(window)))
        }
        
        let stackView = InstantController(views: views, type: .vstack, caller: self)
        
        return stackView.view
    }
    
    public static subscript(_ content: any Component...) -> [any Component] {
        return content
    }
    
    public func render_windows(_ window: Window) {
        
    }
    
    public func fixed_size(width: Int, height: Int) -> Instant {
        var copy = self
        if height < 0 {
            #warning("Height should not be less than 0")
        }
        if width < 0 {
            #warning("Width should not be less than 0")
        }
        copy.height = height
        copy.width = width
        return copy
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
    
    private var height: Int? = nil
    private var width: Int? = nil
    
    @ComponentBuilder public var content: () -> [any Component]
    
    public init(@ComponentBuilder content: @escaping () -> [any Component]) {
        self.content = content
    }
    
    public func render_linux(_ window: Window) {
        
    }
    
    func GetOpts() -> (Int, Int) {
        var finalWidth = -1
        var finalHeight = -1
        if let width = self.width {
            finalWidth = width
        }
        if let height = self.height {
            finalHeight = height
        }
        return (finalWidth, finalHeight)
    }
    
    public func render_macOS(_ window: Window) -> NSView {
        var views: [AnyNSViewRepresentable] = []
        for component in content() {
            views.append(AnyNSViewRepresentable(nsView: component.render_macOS(window)))
        }
        let stackView = InstantController(views: views, type: .hstack, caller: self)
        
        return stackView.view
    }
    
    public func fixed_size(width: Int, height: Int) -> Row {
        var copy = self
        if height < 0 {
            #warning("Height should not be less than 0")
        }
        if width < 0 {
            #warning("Width should not be less than 0")
        }
        copy.height = height
        copy.width = width
        return copy
    }
    
    public static subscript(_ content: any Component...) -> [any Component] {
        return content
    }
    
    public func render_windows(_ window: Window) {
        
    }
}

public typealias Column = Instant

struct VerticalScrollView: View {
    var views: [AnyNSViewRepresentable]
    let caller: VerticalScrollFrame
    var body: some View {
        if caller.GetOpts().0 == -1 && caller.GetOpts().1 == -1 {
            ScrollView(.vertical) {
                VStack {
                    ForEach(0..<views.count, id: \.self ) { index in
                        views[index]
                    }
                }
            }
        } else {
            ScrollView(.vertical) {
                VStack {
                    ForEach(0..<views.count, id: \.self) { index in
                        views[index]
                    }
                }
            }
            .frame(width: CGFloat(integerLiteral: caller.GetOpts().0), height: CGFloat(integerLiteral: caller.GetOpts().1))
        }
    }
}

struct VerticalView: View {
    var views: [AnyNSViewRepresentable]
    let caller: Instant
    var body: some View {
        if caller.GetOpts().0 == -1 && caller.GetOpts().1 == -1 {
            VStack {
                ForEach(0..<views.count, id: \.self ) { index in
                    views[index]
                }
            }
        } else {
            VStack {
                ForEach(0..<views.count, id: \.self) { index in
                    views[index]
                }
            }.frame(width: CGFloat(integerLiteral: caller.GetOpts().0), height: CGFloat(integerLiteral: caller.GetOpts().1))
        }
        
    }
}

struct HorizontalView: View {
    var views: [AnyNSViewRepresentable]
    let caller: Row
    var body: some View {
        if caller.GetOpts().0 == -1 && caller.GetOpts().1 == -1 {
            HStack {
                ForEach(0..<views.count, id: \.self ) { index in
                    views[index]
                }
            }
        } else {
            HStack {
                ForEach(0..<views.count, id: \.self) { index in
                    views[index]
                }
            }.frame(width: CGFloat(integerLiteral: caller.GetOpts().0), height: CGFloat(integerLiteral: caller.GetOpts().1))
        }
    }
}

struct ZStackView: View {
    var views: [AnyNSViewRepresentable]
    let caller: CompactSpace
    var body: some View {
        if caller.GetOpts().0 == -1 && caller.GetOpts().1 == -1 {
            VStack {
                ForEach(0..<views.count, id: \.self ) { index in
                    views[index]
                }
            }
        } else {
            VStack {
                ForEach(0..<views.count, id: \.self) { index in
                    views[index]
                }
            }.frame(width: CGFloat(integerLiteral: caller.GetOpts().0), height: CGFloat(integerLiteral: caller.GetOpts().1))
        }
    }
}

struct HorizontalScrollView: View {
    var views: [AnyNSViewRepresentable]
    let caller: HorizontalScrollFrame
    var body: some View {
        if caller.GetOpts().0 == -1 && caller.GetOpts().1 == -1 {
            ScrollView(.horizontal) {
                VStack {
                    ForEach(0..<views.count, id: \.self ) { index in
                        views[index]
                    }
                }
            }
        } else {
            ScrollView(.horizontal) {
                VStack {
                    ForEach(0..<views.count, id: \.self) { index in
                        views[index]
                    }
                }
            }
            .frame(width: CGFloat(integerLiteral: caller.GetOpts().0), height: CGFloat(integerLiteral: caller.GetOpts().1))
        }
    }
}

enum InstantTypes {
    case vstack
    case hstack
    case zstack
    case vscroller
    case hscroller
}

class InstantController: NSViewController {
    private let views: [AnyNSViewRepresentable]
    private let type: InstantTypes
    private let caller: Any
    init(views: [AnyNSViewRepresentable], type: InstantTypes, caller: Any) {
        self.views = views
        self.type = type
        self.caller = caller
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (type == .vscroller) {
            let swiftView = VerticalScrollView(views: views, caller: caller as! VerticalScrollFrame)
            
            let hostingView = NSHostingView(rootView: swiftView)
            hostingView.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(hostingView)
            
            NSLayoutConstraint.activate([
                hostingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                hostingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                hostingView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
                hostingView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
            ])
        } else if (type == .vstack) {
            let swiftView = VerticalView(views: views, caller: caller as! Instant)
            
            let hostingView = NSHostingView(rootView: swiftView)
            hostingView.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(hostingView)
            
            NSLayoutConstraint.activate([
                hostingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                hostingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                hostingView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
                hostingView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)])
        } else if (type == .hstack) {
            let swiftView = HorizontalView(views: views, caller: caller as! Row)
            
            let hostingView = NSHostingView(rootView: swiftView)
            hostingView.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(hostingView)
            
            NSLayoutConstraint.activate([
                hostingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                hostingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                hostingView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
                hostingView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)])
        } else if (type == .zstack) {
            let swiftView = ZStackView(views: views, caller: caller as! CompactSpace)
            
            let hostingView = NSHostingView(rootView: swiftView)
            hostingView.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(hostingView)
            
            NSLayoutConstraint.activate([
                hostingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                hostingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                hostingView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
                hostingView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)])
        } else if (type == .hscroller) {
            let swiftView = HorizontalScrollView(views: views, caller: caller as! HorizontalScrollFrame)
            
            let hostingView = NSHostingView(rootView: swiftView)
            hostingView.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(hostingView)
            
            NSLayoutConstraint.activate([
                hostingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                hostingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                hostingView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
                hostingView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)])
        }
    }
}

@Component
public struct VerticalScrollFrame {
    private var width: Int? = nil
    private var height: Int? = nil
    @ComponentBuilder public var content: () -> [any Component]
    private var expandVar = false
    
    public init(@ComponentBuilder content: @escaping () -> [any Component]) {
        self.content = content
    }
    
    public static subscript(_ content: any Component...) -> [any Component] {
        return content
    }
    
    public func render_linux(_ window: Window) {
        
    }
    
    func GetOpts() -> (Int, Int) {
        var finalWidth = -1
        var finalHeight = -1
        if let width = self.width {
            finalWidth = width
        }
        if let height = self.height {
            finalHeight = height
        }
        return (finalWidth, finalHeight)
    }
    
    public func render_windows(_ window: Window) {
        
    }
    
    public func fixed_size(width: Int, height: Int) -> VerticalScrollFrame {
        var copy = self
        if height < 0 {
            #warning("Height should not be less than 0")
        }
        if width < 0 {
            #warning("Width should not be less than 0")
        }
        copy.height = height
        copy.width = width
        return copy
    }
    
    public func render_macOS(_ window: Window) -> NSView {
        var views: [AnyNSViewRepresentable] = []
        for component in content() {
            views.append(AnyNSViewRepresentable(nsView: component.render_macOS(window)))
        }
        
        let controller = InstantController(views: views, type: .vscroller, caller: self)
        return controller.view
    }
}

@Component
public struct HorizontalScrollFrame {
    private var width: Int? = nil
    private var height: Int? = nil
    @ComponentBuilder public var content: () -> [any Component]
    private var expandVar = false
    
    public init(@ComponentBuilder content: @escaping () -> [any Component]) {
        self.content = content
    }
    
    public static subscript(_ content: any Component...) -> [any Component] {
        return content
    }
    
    public func render_linux(_ window: Window) {
        
    }
    
    public func fixed_size(width: Int, height: Int) -> HorizontalScrollFrame {
        var copy = self
        if height < 0 {
            #warning("Height should not be less than 0")
        }
        if width < 0 {
            #warning("Width should not be less than 0")
        }
        copy.height = height
        copy.width = width
        return copy
    }
    
    func GetOpts() -> (Int, Int) {
        var finalWidth = -1
        var finalHeight = -1
        if let width = self.width {
            finalWidth = width
        }
        if let height = self.height {
            finalHeight = height
        }
        return (finalWidth, finalHeight)
    }
    
    public func render_windows(_ window: Window) {
        
    }
    
    public func render_macOS(_ window: Window) -> NSView {
        var views: [AnyNSViewRepresentable] = []
        for component in content() {
            views.append(AnyNSViewRepresentable(nsView: component.render_macOS(window)))
        }
        
        let controller = InstantController(views: views, type: .hscroller, caller: self)
        return controller.view
    }
}

@Component
public struct CompactSpace {
    private var width: Int? = nil
    private var height: Int? = nil
    @ComponentBuilder public var content: () -> [any Component]
    private var expandVar = false
    
    public init(@ComponentBuilder content: @escaping () -> [any Component]) {
        self.content = content
    }
    
    public static subscript(_ content: any Component...) -> [any Component] {
        return content
    }
    
    public func render_linux(_ window: Window) {
        
    }
    
    func GetOpts() -> (Int, Int) {
        var finalWidth = -1
        var finalHeight = -1
        if let width = self.width {
            finalWidth = width
        }
        if let height = self.height {
            finalHeight = height
        }
        return (finalWidth, finalHeight)
    }
    
    public func fixed_size(width: Int, height: Int) -> CompactSpace {
        var copy = self
        if height < 0 {
            #warning("Height should not be less than 0")
        }
        if width < 0 {
            #warning("Width should not be less than 0")
        }
        copy.height = height
        copy.width = width
        return copy
    }
    
    public func render_windows(_ window: Window) {
        
    }
    
    public func render_macOS(_ window: Window) -> NSView {
        var views: [AnyNSViewRepresentable] = []
        for component in content() {
            views.append(AnyNSViewRepresentable(nsView: component.render_macOS(window)))
        }
        
        let controller = InstantController(views: views, type: .zstack, caller: self)
        return controller.view
    }
}
