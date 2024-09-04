//
//  Macros.swift
//
//
//  Created by Max Van den Eynde on 4/9/24.
//

import CatamaranMacros
import SwiftSyntax

@attached(member, names: named(component_name), named(component_type))
public macro Component() = #externalMacro(module: "CatamaranMacros", type: "ComponentMacroImplementation")

@attached(member, names: named(component_name), named(component_type))
public macro DistantComponent() = #externalMacro(module: "CatamaranMacros", type: "DistantMacroImplementation")
