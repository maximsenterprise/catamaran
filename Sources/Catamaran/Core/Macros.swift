//
//  Macros.swift
//
//
//  Created by Max Van den Eynde on 4/9/24.
//

import CatamaranMacros
import SwiftSyntax

@attached(extension, conformances: Component)
public macro Component() = #externalMacro(module: "CatamaranMacros", type: "ComponentMacroImplementation")

@attached(extension, conformances: DistantComponent)
public macro DistantComponent() = #externalMacro(module: "CatamaranMacros", type: "DistantMacroImplementation")

@attached(extension, conformances: PredicateComponent)
public macro PredicateComponent() = #externalMacro(module: "CatamaranMacros", type: "PredicateMacroImplementation")

@attached(extension, conformances: TransientComponent)
public macro TransientComponent() = #externalMacro(module: "CatamaranMacros", type: "TransientMacroImplementation")

@attached(extension, conformances: StaticComponent)
public macro StaticComponent() = #externalMacro(module: "CatamaranMacros", type: "StaticMacroImplementation")

@attached(extension, conformances: WindowsComponent)
public macro WindowsComponent() = #externalMacro(module: "CatamaranMacros", type: "WindowsMacroImplementation")

@attached(extension, conformances: LinuxComponent)
public macro LinuxComponent() = #externalMacro(module: "CatamaranMacros", type: "LinuxMacroImplementation")

@attached(extension, conformances: MacComponent)
public macro MacComponent() = #externalMacro(module: "CatamaranMacros", type: "MacMacroImplementation")
