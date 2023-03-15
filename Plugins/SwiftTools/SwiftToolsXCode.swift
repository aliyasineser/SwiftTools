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
        ].compactMap{$0}
    }
}

#endif


