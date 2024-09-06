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
        // Let's test dynamism
        
        let window = Window(name: "My Catamaran Window")
        let texts: [String] = ["Hello", "This", "Is", "An", "ITERATOR"]
        
        let instant = IteratorComponent<String>(texts) { text in
            TextComponent(text)
        }
        Application.attach_window(window)
        Application.render_at(stage: .window, component: instant)
        Application.begin()
    }
}
