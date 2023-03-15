//
//  File.swift
//  
//
//  Created by Ali Yasin Eser on 15.03.23.
//

import Foundation
import PackagePlugin

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

// MARK: - XCodeProjectPlugin Swiftgen
extension SwiftTools {
    func swiftGen(context: XcodePluginContext, target: XcodeTarget) throws -> Command {
        let inputFilesPath = context.xcodeProject.directory
        let outputFilesPath = context.pluginWorkDirectory.appending("Generated")
        let environment = [
            "INPUT_DIR": inputFilesPath,
            "OUTPUT_DIR": outputFilesPath
        ]
        return .prebuildCommand(
            displayName: "Running SwiftGen for \(target.displayName)",
            executable: try context.tool(named: "swiftgen").path,
            arguments: prepareArgumentsForSwiftGen(context: context, projectDirectory: context.xcodeProject.directory),
            environment: environment,
            outputFilesDirectory: outputFilesPath)
    }

    private func prepareArgumentsForSwiftGen(
        context: XcodePluginContext,
        projectDirectory: Path
    ) -> [CustomStringConvertible] {
        let configPath = context.xcodeProject.filePaths.first { $0.lastComponent == "swiftgen.yml"} ?? projectDirectory.appending("swiftgen.yml")
        return  [
            "config",
            "run",
            "--verbose",
            "--config",
            configPath
        ]
    }
}

#endif
