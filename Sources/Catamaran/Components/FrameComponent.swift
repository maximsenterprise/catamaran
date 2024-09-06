//
//  FrameComponent.swift
//
//
//  Created by Max Van den Eynde on 3/9/24.
//

import Foundation
#if os(macOS)
import Cocoa
#endif

/// A Component that represents the boundries and the core of a Catamaran Window
@DistantComponent
public class FrameComponent {
    public var window: NSWindow?
    public var windowComponent: Window
    #if os(macOS)
    private class AppDelegate: NSObject, NSApplicationDelegate {
        
        var window: NSWindow?
        
        weak var frameComponent: FrameComponent?
        weak var windowComponent: Window?
        let name: String
        
        init(frameComponent: FrameComponent, windowComponent: Window, name: String) {
            self.frameComponent = frameComponent
            self.windowComponent = windowComponent
            self.name = name
        }

        func applicationDidFinishLaunching(_ notification: Notification) {
            // Define el tamaño de la ventana
            let screenSize = NSScreen.main?.frame.size ?? CGSize(width: 800, height: 600)
            let windowSize = CGSize(width: 800, height: 600)
            let windowRect = NSRect(x: (screenSize.width - windowSize.width) / 2,
                                    y: (screenSize.height - windowSize.height) / 2,
                                    width: windowSize.width,
                                    height: windowSize.height)
            
            // Crea la ventana
            window = NSWindow(contentRect: windowRect,
                              styleMask: [.titled, .closable, .resizable, .miniaturizable],
                              backing: .buffered,
                              defer: false)
            window?.title = name
            frameComponent?.window = window
            
            if !Application.queue.isEmpty {
                for function in Application.queue {
                    #if os(macOS)
                    let result: Any = function(windowComponent!)
                    window?.contentView = result as? NSView
                    #endif
                }
            }
            // Muestra la ventana en el dock
            window?.makeKeyAndOrderFront(nil)
            
            // Establece el icono en el dock (si se necesita un icono específico, asegúrate de configurarlo en Info.plist)
            NSApp.setActivationPolicy(.regular)
        }
        
        func applicationWillTerminate(_ notification: Notification) {
            
        }
    }
    #endif
    
    let name: String
    public func start() {
        #if os(macOS)
        let app = NSApplication.shared
        let delegate = AppDelegate(frameComponent: self, windowComponent: windowComponent, name: name)
        app.delegate = delegate
        app.run()
        return
        #elseif os(Windows)
        
        #endif
    }
    
    init(name: String, parent: Window) {
        self.windowComponent = parent
        self.name = name
    }
}
