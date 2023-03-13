//
//  File.swift
//  
//
//  Created by Ali Yasin Eser on 13.03.23.
//

import Foundation
import PackagePlugin

@main
struct SwiftTools: BuildToolPlugin {
    func createBuildCommands(context: PackagePlugin.PluginContext, target: PackagePlugin.Target) async throws -> [PackagePlugin.Command] {
        return [
            // We are updating Xcode project and targets so no need to implement BuildToolPlugin
        ]
    }
}
