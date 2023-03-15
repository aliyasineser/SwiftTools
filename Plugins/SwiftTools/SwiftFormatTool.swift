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

// MARK: - XCodeProjectPlugin SwiftFormat
extension SwiftTools {
    func swiftFormat(context: XcodePluginContext, target: XcodeTarget) throws -> Command? {
        guard let configPath = context.xcodeProject.filePaths.first(where: { pathItem in pathItem.lastComponent == ".swiftformat" }) else { return nil }

        return .prebuildCommand(
            displayName: "Running SwiftFormat for \(target.displayName)",
            executable: try context.tool(named: "swiftformat").path,
            arguments: prepareArgumentsForSwiftFormat(
                configPath: configPath,
                target: target,
                packageDirectory: context.xcodeProject.directory,
                workingDirectory: context.pluginWorkDirectory
            ),
            environment: [:],
            outputFilesDirectory: context.pluginWorkDirectory
        )
    }

    private func prepareArgumentsForSwiftFormat(
        configPath: Path,
        target: XcodeTarget,
        packageDirectory: Path,
        workingDirectory: Path
    ) -> [CustomStringConvertible] {
        let inputFiles = target.inputFiles
            .filter { $0.type == .source && $0.path.extension == "swift" }
            .map(\.path)

        var arguments: [CustomStringConvertible] = [
            "--verbose",
            "--config",
            configPath,
        ]

        arguments += inputFiles.map(\.string)

        return arguments
    }

}

#endif
