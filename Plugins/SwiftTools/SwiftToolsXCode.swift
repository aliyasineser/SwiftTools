//
//  File.swift
//  
//
//  Created by Ali Yasin Eser on 14.03.23.
//

import Foundation
import PackagePlugin

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

extension SwiftTools: XcodeBuildToolPlugin {
    func createBuildCommands(context: XcodePluginContext, target: XcodeTarget) throws -> [Command] {
        [
            try swiftLint(context: context, target: target),
            try swiftFormat(context: context, target: target),
            try swiftGen(context: context, target: target)
        ]
    }

}

// MARK: - XCodeProjectPlugin SwiftLint
extension SwiftTools {

    private func swiftLint(context: XcodePluginContext, target: XcodeTarget) throws -> Command {

        return .buildCommand(
            displayName: "Running SwiftLint for \(target.displayName)",
            executable: try context.tool(named: "swiftlint").path,
            arguments: prepareArgumentsForSwiftLint(
                target: target,
                packageDirectory: context.xcodeProject.directory,
                workingDirectory: context.pluginWorkDirectory),
            environment: [:]
        )

    }

    private func prepareArgumentsForSwiftLint(
        target: XcodeTarget,
        packageDirectory: Path,
        workingDirectory: Path) -> [String] {
            let inputFiles = target.inputFiles
                .filter { $0.type == .source && $0.path.extension == "swift" }
                .map(\.path)
            let configFile = target.displayName.hasSuffix("Tests") ? "swiftlint-tests.yml" : "swiftlint.yml"
            var arguments = [
                "lint",
                "--quiet",
                "--force-exclude",
                "--cache-path",
                "\(workingDirectory)",
                "--config",
                "\(packageDirectory)/config/\(configFile)",
            ]

            arguments += inputFiles.map(\.string)

            return arguments
        }
}

// MARK: - XCodeProjectPlugin SwiftFormat
extension SwiftTools {
    private func swiftFormat(context: XcodePluginContext, target: XcodeTarget) throws -> Command {
        return .prebuildCommand(
            displayName: "Running SwiftFormat for \(target.displayName)",
            executable: try context.tool(named: "swiftformat").path,
            arguments: prepareArgumentsForSwiftFormat(
                target: target,
                packageDirectory: context.xcodeProject.directory,
                workingDirectory: context.pluginWorkDirectory
            ),
            environment: [:],
            outputFilesDirectory: context.pluginWorkDirectory
        )
    }

    private func prepareArgumentsForSwiftFormat(
        target: XcodeTarget,
        packageDirectory: Path,
        workingDirectory: Path) -> [String] {
            let inputFiles = target.inputFiles
                .filter { $0.type == .source && $0.path.extension == "swift" }
                .map(\.path)
            let configFile = ".swiftformat"
            var arguments = [
                "--verbose",
                "--config",
                "\(packageDirectory)/\(configFile)",
            ]

            arguments += inputFiles.map(\.string)

            return arguments
        }

}

// MARK: - XCodeProjectPlugin Swiftgen
extension SwiftTools {
    private func swiftGen(context: XcodePluginContext, target: XcodeTarget) throws -> Command {
        let inputFilesPath = context.xcodeProject.directory
        let outputFilesPath = context.pluginWorkDirectory.appending("Generated")
        let environment = [
            "INPUT_DIR": inputFilesPath,
            "OUTPUT_DIR": outputFilesPath
        ]
        return .prebuildCommand(
            displayName: "Running SwiftGen for \(target.displayName)",
            executable: try context.tool(named: "swiftgen").path,
            arguments: prepareArgumentsForSwiftGen(projectDirectory: context.xcodeProject.directory),
            environment: environment,
            outputFilesDirectory: outputFilesPath)
    }

    private func prepareArgumentsForSwiftGen(
        projectDirectory: Path
    ) -> [CustomStringConvertible] {
        let configPath = projectDirectory.appending("swiftgen.yml")
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


