//
//  File.swift
//  
//
//  Created by Ali Yasin Eser on 16.03.23.
//

import Foundation
import PackagePlugin

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

// MARK: - XCodeProjectPlugin SwiftLint
extension SwiftTools {

    func swiftLint(context: XcodePluginContext, target: XcodeTarget) throws -> Command {

        return .buildCommand(
            displayName: "Running SwiftLint for \(target.displayName)",
            executable: try context.tool(named: "swiftlint").path,
            arguments: prepareArgumentsForSwiftLint(
                context: context,
                target: target,
                packageDirectory: context.xcodeProject.directory,
                workingDirectory: context.pluginWorkDirectory
            ),
            environment: [:]
        )

    }

    private func prepareArgumentsForSwiftLint(
        context: XcodePluginContext,
        target: XcodeTarget,
        packageDirectory: Path,
        workingDirectory: Path
    ) -> [CustomStringConvertible] {
        let inputFiles = target.inputFiles
            .filter { $0.type == .source && $0.path.extension == "swift" }
            .map(\.path)
        let configPath = context.xcodeProject.filePaths.first { $0.lastComponent == "swiftlint.yml"} ?? packageDirectory.appending("swiftlint.yml")
        var arguments: [CustomStringConvertible] = [
            "lint",
            "--quiet",
            "--force-exclude",
            "--cache-path",
            "\(workingDirectory)",
            "--config",
            configPath,
        ]

        arguments += inputFiles.map(\.string)

        return arguments
    }
}

#endif
