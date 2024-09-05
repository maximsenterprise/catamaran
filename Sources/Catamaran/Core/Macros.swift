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

@attached(member, names: named(component_name), named(component_type))
public macro PredicateComponent() = #externalMacro(module: "CatamaranMacros", type: "PredicateMacroImplementation")

@attached(member, names: named(component_name), named(component_type))
public macro TransientComponent() = #externalMacro(module: "CatamaranMacros", type: "TransientMacroImplementation")

@attached(member, names: named(component_name), named(component_type))
public macro StaticComponent() = #externalMacro(module: "CatamaranMacros", type: "StaticMacroImplementation")

@attached(member, names: named(component_name), named(component_type))
public macro WindowsComponent() = #externalMacro(module: "CatamaranMacros", type: "WindowsMacroImplementation")

@attached(member, names: named(component_name), named(component_type))
public macro LinuxComponent() = #externalMacro(module: "CatamaranMacros", type: "LinuxMacroImplementation")

@attached(member, names: named(component_name), named(component_type))
public macro MacComponent() = #externalMacro(module: "CatamaranMacros", type: "MacMacroImplementation")

@attached(peer)
public macro ComponentTest() = #externalMacro(module: "CatamaranMacros", type: "ComponentTest")
