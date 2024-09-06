//
//  File.swift
//  
//
//  Created by Max Van den Eynde on 4/9/24.
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

@main
struct CatamaranMacrosPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        ComponentMacroImplementation.self,
        DistantMacroImplementation.self,
        StaticMacroImplementation.self,
        MacMacroImplementation.self,
        LinuxMacroImplementation.self,
        WindowsMacroImplementation.self,
        PredicateMacroImplementation.self,
        TransientMacroImplementation.self,
    ]
}
