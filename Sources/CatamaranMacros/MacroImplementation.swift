//
//  Macros.swift
//
//
//  Created by Max Van den Eynde on 4/9/24.
//

import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftCompilerPlugin

public struct ComponentMacroImplementation: MemberMacro {
    public static func expansion(of node: AttributeSyntax, providingMembersOf declaration: some DeclGroupSyntax, in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        guard let type = declaration.as(ClassDeclSyntax.self) else {
            fatalError("The type which this macro is attached is not a class")
        }
        
        let name: String = type.name.text
        
        return [
            DeclSyntax(stringLiteral: "public var component_name: String = \"\(name)\" "),
            DeclSyntax(stringLiteral: "public var component_type: ComponentType = .component "),
        ]
    }
}


public struct DistantMacroImplementation: MemberMacro {
    public static func expansion(of node: AttributeSyntax, providingMembersOf declaration: some DeclGroupSyntax, in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        guard let type = declaration.as(ClassDeclSyntax.self) else {
            fatalError("The type which this macro is attached is not a class")
        }
        
        let name: String = type.name.text
        
        return [
            DeclSyntax(stringLiteral: "public var component_name: String = \"\(name)\" "),
            DeclSyntax(stringLiteral: "public var component_type: ComponentType = .distantComponent "),
        ]
    }
}

public struct PredicateMacroImplementation: MemberMacro {
    public static func expansion(of node: AttributeSyntax, providingMembersOf declaration: some DeclGroupSyntax, in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        guard let type = declaration.as(ClassDeclSyntax.self) else {
            fatalError("The type which this macro is attached is not a class")
        }
        
        let name: String = type.name.text
        
        return [
            DeclSyntax(stringLiteral: "public var component_name: String = \"\(name)\" "),
            DeclSyntax(stringLiteral: "public var component_type: ComponentType = .predicateComponent "),
        ]
    }
}


public struct TransientMacroImplementation: MemberMacro {
    public static func expansion(of node: AttributeSyntax, providingMembersOf declaration: some DeclGroupSyntax, in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        guard let type = declaration.as(ClassDeclSyntax.self) else {
            fatalError("The type which this macro is attached is not a class")
        }
        
        let name: String = type.name.text
        
        return [
            DeclSyntax(stringLiteral: "public var component_name: String = \"\(name)\" "),
            DeclSyntax(stringLiteral: "public var component_type: ComponentType = .transientComponent "),
        ]
    }
}

public struct StaticMacroImplementation: MemberMacro {
    public static func expansion(of node: AttributeSyntax, providingMembersOf declaration: some DeclGroupSyntax, in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        guard let type = declaration.as(ClassDeclSyntax.self) else {
            fatalError("The type which this macro is attached is not a class")
        }
        
        let name: String = type.name.text
        
        return [
            DeclSyntax(stringLiteral: "public var component_name: String = \"\(name)\" "),
            DeclSyntax(stringLiteral: "public var component_type: ComponentType = .staticComponent "),
        ]
    }
}

public struct WindowsMacroImplementation: MemberMacro {
    public static func expansion(of node: AttributeSyntax, providingMembersOf declaration: some DeclGroupSyntax, in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        guard let type = declaration.as(ClassDeclSyntax.self) else {
            fatalError("The type which this macro is attached is not a class")
        }
        
        let name: String = type.name.text
        
        return [
            DeclSyntax(stringLiteral: "public var component_name: String = \"\(name)\" "),
            DeclSyntax(stringLiteral: "public var component_type: ComponentType = .windowsComponent "),
        ]
    }
}

public struct LinuxMacroImplementation: MemberMacro {
    public static func expansion(of node: AttributeSyntax, providingMembersOf declaration: some DeclGroupSyntax, in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        guard let type = declaration.as(ClassDeclSyntax.self) else {
            fatalError("The type which this macro is attached is not a class")
        }
        
        let name: String = type.name.text
        
        return [
            DeclSyntax(stringLiteral: "public var component_name: String = \"\(name)\" "),
            DeclSyntax(stringLiteral: "public var component_type: ComponentType = .linuxComponent "),
        ]
    }
}

public struct MacMacroImplementation: MemberMacro {
    public static func expansion(of node: AttributeSyntax, providingMembersOf declaration: some DeclGroupSyntax, in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        guard let type = declaration.as(ClassDeclSyntax.self) else {
            fatalError("The type which this macro is attached is not a class")
        }
        
        let name: String = type.name.text
        
        return [
            DeclSyntax(stringLiteral: "public var component_name: String = \"\(name)\" "),
            DeclSyntax(stringLiteral: "public var component_type: ComponentType = .macComponent "),
        ]
    }
}
