# spm-plugins

On the Swift forums the future of the Swift Package Manager was discussed with respect to supporting more complex builds:
https://forums.swift.org/t/spm-static-dependencies/10152/35

One of the main points that was dicussed is that the Package.swift manifest should only contain a restricted subset of the Swift language, which makes it machine editable. This repository provides a proof of concept that accomplishes this by moving any complex build functionality into a subpackage 'BuildSupport'. This BuildSuport package is always built before the main package and therefore can provide plugins that hook into the Swift Package Manager when it is building the main package. Naturally, the BuildSupport package can depend on other packages to make it possible to import complex build systems into the project.

The BuildSupport example provides two plugins:
- ConditionalDependencies: Makes it possible to add dependencies only if a certain condition is true
- KernelInfo: Provides information about whether the kernel supports IPv4/IPv6 (stub)

These plugins are used from the main Package.swift and determine whether the IPv4/IPv6 modules of the main package have to be compiled. This is just a simple example based on what is 'possible' today. Real plugin support would make much more complex functionality possible.

## Hack
Obviously the current Swift Package Manager does not support this, but with a hack I was able to get the example working in a Linux environment.
If you want to try this, note that it requires Swift to be installed in /usr

**Note:** This project heavily depends on the system configuration and has only been tested in the swift:4.0.3 Docker image.

## Usage
To build the example, a 'swift-build' script is provided. This must be used instead of 'swift build':
```
cd path/to/spm-plugins
./swift-build
```

## Swift Package Manager plugin support
This proof of concept only provides a very basic plugin example that could be accomplished with the SPM we have today. However, if the Swift Package Manager in the future could provide carefully designed hooks that can be used by plugins, more complex build extensions can be supported as well.

For example, a plugin for a code generator tool could define a specific target configuration class. Configuration for the code generator tool can then be specified in the Package.swift file and dependencies from/to other targets can be defined. When it is time to build the target, the Swift Package Manager hands of the build task to the plugin, which knows how to run the code generator tool.

## How the hack works
The 'swift-build' script sets-up a Swift environment in a local directory (copied from /usr). In this environment swiftc is replaced with a script that executes the actual swiftc, but with additional arguments. These arguments are used to link the plugins into the main Package.swift.

With this environment in place, the script basically calls 'swift build' twice. First for the BuildSupport package and then for the main package.

