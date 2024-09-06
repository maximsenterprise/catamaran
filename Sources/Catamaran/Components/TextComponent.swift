//
//  TextComponent.swift
//
//
//  Created by Max Van den Eynde on 4/9/24.
//


#if os(macOS)
import Cocoa
import SwiftUI
#endif

class TextViewController: NSViewController {
    private var text: String
    private var bold: Bool
    private var italic: Bool
    private var weight: CGFloat
    
    init(text: String, bold: Bool, italic: Bool, weigth: CGFloat) {
        self.text = text
        self.bold = bold
        self.italic = italic
        self.weight = weigth
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swiftView = FinalTextView(text: text, bold: bold, italic: italic, weight: weight)
        
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

struct FinalTextView: View {
    let text: String
    let bold: Bool
    let italic: Bool
    let weight: CGFloat
    
    init(text: String, bold: Bool, italic: Bool, weight: CGFloat) {
        self.text = text
        self.italic = italic
        self.bold = bold
        self.weight = weight
    }
    
    var body: some View {
        if bold {
            Text(text)
                .font(.system(size: weight, weight: .bold))
        } else if italic {
            Text(text)
                .font(.system(size: weight))
                .italic()
        } else {
            Text(text)
        }
    }
}


/// Component that displays a text on Screen
///
/// In macOS this component renders a `Text` into the screen. This uses the `SwiftUI` library with a `NSViewController` and `NSHostingView`
@Component
public class TextComponent {
    let text: String
    var boldVar: Bool = false
    var italicVar: Bool = false
    var weightVar: CGFloat = 0
    public func render_linux(_ window: Window) {}
    
    public func render_macOS(_ window: Window) -> NSView {
        return TextViewController(text: text, bold: boldVar, italic: italicVar, weigth: weightVar).view
    }
    
    public func bold() -> TextComponent {
        self.boldVar = true
        return self
    }
    
    public func italic() -> TextComponent {
        self.italicVar = true
        return self
    }
    
    public func setWeight(to: CGFloat) -> TextComponent {
        self.weightVar = to
        return self
    }
    
    public func render_windows(_ window: Window) {}
    
    public init(_ text: String) {
        self.text = text
    }
}
