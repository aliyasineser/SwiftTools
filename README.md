# SwiftTools

One plugin to use swiftlint, swiftformat and swiftgen.

# Motivation

For big project it becomes hard to manage dependencies in time. This plugin consists necessary swift tools for the codebase. When the configuration files are present in the project directory, all the targets will use the tools in the prebuild step and as a developer you won't have to create some bash scripts and run your command line tools for the job. You also don't need to add pre-build steps in your targets build phases, which makes easier to introduce a new module without having extra manual work.

Please provide following config files and make sure they are present as references in the XCode project. For every project you have, you need to have references. You can have only one config and share it among projects, but references are needed since plugin will search the project references:

- swiftgen.yml
- swiftlint.yml
- .swiftformat
- .swift-version
