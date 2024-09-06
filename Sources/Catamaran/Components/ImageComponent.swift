//
//  ImageComponent.swift
//
//
//  Created by Max Van den Eynde on 4/9/24.
//

import Foundation
import Cocoa
import SwiftUI

struct FinalImageView: View {
    let source: String
    
    init(source: String) {
        self.source = source
    }
    
    var body: some View {
        Image(source)
    }
}

class ImageViewController: NSViewController {
    private var src: String
    
    init(src: String) {
        self.src = src
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swiftView = FinalImageView(source: src)
        
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
public class ImageComponent {
    let source: String
    public func render_linux(_ window: Window) {
        
    }
    
    public func render_macOS(_ window: Window) -> NSView {
        return ImageViewController(src: source).view
    }
    
    public func render_windows(_ window: Window) {
        
    }
    
    public init(source: String) {
        self.source = source
    }
}
