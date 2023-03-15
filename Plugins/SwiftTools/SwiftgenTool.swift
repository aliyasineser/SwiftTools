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
    func swiftGen(context: XcodePluginContext, target: XcodeTarget) throws -> Command? {
        guard let configPath = context.xcodeProject.filePaths.first(where: { pathItem in pathItem.lastComponent == "swiftgen.yml" }) else { return nil }

        let inputFilesPath = context.xcodeProject.directory
        let outputFilesPath = context.pluginWorkDirectory.appending("Generated")
        let environment = [
            "INPUT_DIR": inputFilesPath,
            "OUTPUT_DIR": outputFilesPath
        ]
        return .prebuildCommand(
            displayName: "Running SwiftGen for \(target.displayName)",
            executable: try context.tool(named: "swiftgen").path,
            arguments: prepareArgumentsForSwiftGen(configPath: configPath, projectDirectory: context.xcodeProject.directory),
            environment: environment,
            outputFilesDirectory: outputFilesPath
        )
    }

    private func prepareArgumentsForSwiftGen(
        configPath: Path,
        projectDirectory: Path
    ) -> [CustomStringConvertible] {
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
