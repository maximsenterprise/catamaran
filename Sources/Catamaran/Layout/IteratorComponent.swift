//
//  IteratorComponent.swift
//
//
//  Created by Max Van den Eynde on 6/9/24.
//

import Foundation
import AppKit
import SwiftUI

struct VStackForeach: View {
    var list: [AnyNSViewRepresentable]
    var body: some View {
        VStack {
            ForEach(0..<list.count, id: \.self) { index in
                list[index]
            }
        }
    }
}

class ForEachController: NSViewController {
    private var representables: [AnyNSViewRepresentable]
    
    init(representables: [AnyNSViewRepresentable]) {
        self.representables = representables
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swiftView = VStackForeach(list: representables)
        
        let hostingView = NSHostingView(rootView: swiftView)
        hostingView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(hostingView)
        
        NSLayoutConstraint.activate([
            hostingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hostingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            hostingView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            hostingView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
    }
}

@Component
public struct IteratorComponent<T> {
    @ComponentBuilder var content: (T) -> [any Component]
    var list: [T]
    
    public init(_ iterating: [T], @ComponentBuilder content: @escaping (T) -> [any Component]) {
        self.content = content
        self.list = iterating
    }
    
    public static subscript(_ content: any Component...) -> [any Component] {
        return content
    }
    
    public func render_linux(_ window: Window) {
        
    }
    
    public func render_macOS(_ window: Window) -> NSView {
        var finalElements: [AnyNSViewRepresentable] = []
        for element in list {
            let components = content(element)
            let vstack = Column(content: {() -> [any Component] in return components})
            finalElements.append(AnyNSViewRepresentable(nsView: vstack.render_macOS(window)))
        }
        let finalController = ForEachController(representables: finalElements)
        return finalController.view
    }
    
    public func render_windows(_ window: Window) {
        
    }
}
