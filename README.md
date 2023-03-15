# SwiftTools

One plugin to use swiftlint, swiftformat and swiftgen.

# Motivation

For big project it becomes hard to manage dependencies in time. This plugin consists necessary swift tools for the codebase. When the configuration files are present in the project directory, all the targets will use the tools in the prebuild step and as a developer you won't have to create some bash scripts and run your command line tools for the job. You also don't need to add pre-build steps in your targets build phases, which makes easier to introduce a new module without having extra manual work.

Please provide following config files in given path(will be configurable in future):

- swiftgen.yml -> <Project_Directory>/swiftgen.yml
- swiftlint.yml -> <Project_Directory>/swiftlint.yml
- swiftlint-tests.yml -> <Project_Directory>/swiftlint-tests.yml
- .swiftformat -> <Project_Directory>/.swiftformat
- .swift-version -> <Project_Directory>/.swift-version
