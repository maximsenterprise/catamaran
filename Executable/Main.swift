//
//  File.swift
//  
//
//  Created by Max Van den Eynde on 4/9/24.
//

import Catamaran

@main
class Main {
    static func main() {
        let window = Window(name: "My Catamaran Window")
        
        let instant = Instant {
            TextComponent("lápiz")
        }
        
        Application.attach_window(window)
        Application.render_at(stage: .window, component: instant)
        Application.begin()
    }
}
