//
//  FrameComponent.swift
//
//
//  Created by Max Van den Eynde on 3/9/24.
//

import Foundation
import Cocoa
import MetalKit

/// A Component that represents the boundries and the core of a Catamaran Window
@DistantComponent
class FrameComponent: DistantComponent {
    let name: String
    func start() {
        #if os(macOS)
        let screenSize = NSScreen.main?.frame.size ?? CGSize(width: 800, height: 600)
        let windowSize = CGSize(width: 800, height: 600)
        let windowRect = NSRect(x: (screenSize.width - windowSize.width) / 2,
                                y: (screenSize.height - windowSize.height) / 2,
                                width: windowSize.width,
                                height: windowSize.height)

        let window = NSWindow(contentRect: windowRect,
                              styleMask: [.titled, .closable, .resizable, .miniaturizable],
                              backing: .buffered,
                              defer: false)
        window.title = self.name
        
        let metalView = MTKView(frame: window.contentView!.bounds)
        metalView.device = MTLCreateSystemDefaultDevice()
        metalView.colorPixelFormat = .bgra8Unorm
        metalView.clearColor = MTLClearColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)

        window.contentView = metalView
        window.makeKeyAndOrderFront(nil)
        
        if let drawable = metalView.currentDrawable,
           let descriptor = metalView.currentRenderPassDescriptor {
            let commandQueue = metalView.device?.makeCommandQueue()
            let commandBuffer = commandQueue?.makeCommandBuffer()

            let renderEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: descriptor)
            renderEncoder?.endEncoding()

            commandBuffer?.present(drawable)
            commandBuffer?.commit()
        }
        
        NSApp.run()
        #elseif os(Windows)
        
        #endif
    }
    
    init(name: String) {
        self.name = name
    }
}
