//
//  Main.swift
//
//
//  Created by Max Van den Eynde on 6/9/24.
//

import Foundation

struct CatamaranFile: Codable {
    let name: String
    let executable: String
    let outPath: String
    let infoplist: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case executable = "executable"
        case outPath = "outPath"
        case infoplist = "info"
    }
}

@main
class CatmaranCLI {
    static let boldStart = "\u{001B}[1m"
    static let end = "\u{001B}[0m"
    static let italicStart = "\u{001B}[3m"
    static func main() {
        let arguments = CommandLine.arguments
        
        if arguments.count == 1 {
            usage()
        } else if arguments.count == 2 {
            if arguments[1] == "bundle" {
                prebundle()
            }
        }
    }
    
    static func usage() {
        print("Catamaran")
        print("Version 1.0.0 Alpha")
        print("Created by Maxims Enterprise")
        print("----------------------------")
        print(boldStart + "Tools" + end)
        print(italicStart + "bundle" + end + " -> Bundle the actual application for macOS. Usage: [catamaran bundle] PathTo.catamaran")
    }
    
    public static func prebundle() {
        let fileManager = FileManager.default
        let cwd = fileManager.currentDirectoryPath
        if fileManager.fileExists(atPath: cwd + "/.catamaran") {
            do {
                let fileContent = try String(contentsOfFile: cwd + "/.catamaran")
                let decoder = JSONDecoder()
                let opts = try decoder.decode(CatamaranFile.self, from: fileContent.data(using: .utf8)!)
                bundle_at(path: opts.executable, name: opts.name, outPath: opts.outPath)
            } catch {
                fatalError("Error when reading: \(error)")
            }
        } else {
            print("File do not exist")
        }
    }
    
    public static func bundle_at(path: String, name: String, outPath: String) {
        do {
            let fileManager = FileManager.default
            let outPathURL = URL(fileURLWithPath: outPath)
            let appPath = outPathURL.appendingPathComponent("/" + name + ".app")
            let contents = appPath.appendingPathComponent("/Contents")
            if fileManager.fileExists(atPath: appPath.absoluteString) {
                try removeDirectory(at: appPath.absoluteString)
            }
            try fileManager.createDirectory(at: appPath, withIntermediateDirectories: true, attributes: nil)
            try fileManager.createDirectory(at: contents, withIntermediateDirectories: true, attributes: nil)
            
            let macOSPath = contents.appendingPathComponent("/MacOS")
            let resourcesPath = contents.appendingPathComponent("/Resources")
            try fileManager.createDirectory(at: macOSPath, withIntermediateDirectories: true, attributes: nil)
            try fileManager.createDirectory(at: resourcesPath, withIntermediateDirectories: true, attributes: nil)
            
            let executableURL = URL(fileURLWithPath: path)
            let finalURL = macOSPath.appendingPathComponent("/" + name)
            try fileManager.copyItem(at: executableURL, to: finalURL)
            
            let infoplist = appPath.appendingPathComponent("/Info.plist")
            fileManager.createFile(atPath: infoplist.absoluteString, contents: nil)
        } catch {
            fatalError("Error when bundling: \(error)")
        }
    }
}

func removeDirectory(at path: String) throws {
    let fileManager = FileManager.default
    let url = URL(fileURLWithPath: path)
    
    guard fileManager.fileExists(atPath: path) else {
        fatalError("The directory does not exist")
    }
    
    let contents = try fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
    
    for file in contents {
        try fileManager.removeItem(at: file)
    }
    
    try fileManager.removeItem(at: url)
}
