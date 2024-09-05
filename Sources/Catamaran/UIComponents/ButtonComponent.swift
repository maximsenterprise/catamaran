//
//  ButtonComponent.swift
//
//
//  Created by Max Van den Eynde on 4/9/24.
//

#if os(macOS)
import Cocoa
import SwiftUI
#endif

struct ButtonView: View {
    var onOrOff: PredicateResult
    var labels: [AnyNSViewRepresentable]
    var perform: () -> ()
    var body: some View {
        Button {
            perform()
        } label: {
            VStack {
                ForEach(0..<labels.count, id: \.self) { index in
                    labels[index]
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
    }
}

class ButtonViewController: NSViewController {
    private var perform: () -> ()
    private var representables: [AnyNSViewRepresentable]
    var onOff: PredicateResult
    
    init(perform: @escaping () -> (), representables: [AnyNSViewRepresentable], onOff: PredicateResult) {
        self.perform = perform
        self.representables = representables
        self.onOff = onOff
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swiftView = ButtonView(onOrOff: onOff, labels: representables, perform: perform)
        
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

public struct AnyNSViewRepresentable: NSViewRepresentable {
    let nsView: NSView
    
    init(nsView: NSView) {
        self.nsView = nsView
    }
    
    public func makeNSView(context: Context) -> NSView {
        return nsView
    }
    
    public func updateNSView(_ nsView: NSView, context: Context) {
        
    }
}

public struct ButtonComponent: PredicateComponent {
    @ComponentBuilder public var content: () -> [any Component]
    public var perform: () -> ()
    
    public init(@ComponentBuilder content: @escaping () -> [any Component], perform: @escaping () -> ()) {
        self.content = content
        self.perform = perform
    }
    
    public static subscript(_ content: any Component...) -> [any Component] {
        return content
    }
    
    public func render_linux(_ window: Window) {
        
    }
    
    public func render_macOS(_ window: Window) -> NSView {
        var representables: [AnyNSViewRepresentable] = []
        for component in content() {
            representables.append(AnyNSViewRepresentable(nsView: component.render_macOS(window)))
        }
        let controller = ButtonViewController(perform: perform, representables: representables, onOff: result)
        return controller.view
    }
    
    public func render_windows(_ window: Window) {
        
    }
    
    public var result: PredicateResult = .off
    public var component_name: String = "ButtonComponent"
    public var component_type: ComponentType = .transientComponent
}
