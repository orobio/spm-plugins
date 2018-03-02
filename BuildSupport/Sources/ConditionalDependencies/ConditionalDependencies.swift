// ConditionalDependencies.swift
//
// Simple example of adding functionality to Package.manifest.
// It makes it possible to add dependencies only if a certain
// condition is true.
//

import PackageDescription

extension Package {
    public convenience init(name: String, targets: [Target?]) {
        self.init(name: name, targets: targets.flatMap { $0 })
    }

    public convenience init(name: String, products: [Product], targets: [Target?]) {
        self.init(name: name, products: products, targets: targets.flatMap { $0 })
    }
}

public struct LibraryTarget {
    let _name: String
    public static func target(condition: Bool, name: String) -> LibraryTarget? {
        return (condition) ? (LibraryTarget(_name: name)) : (nil)
    }
}

extension Product {
    public static func library(name: String, type: Library.LibraryType? = nil, targets: [LibraryTarget?]) -> Product {
        return .library(name: name, type: type, targets: targets.flatMap { $0?._name })
    }
}

extension Target {
    public static func target(condition: Bool, name: String) -> Target? {
        return (condition) ? (.target(name: name)) : (nil)
    }

    public static func target(name: String, dependencies: [Target.Dependency?]) -> Target {
        return .target(name: name, dependencies: dependencies.flatMap { $0 })
    }
}

extension Target.Dependency {
    public static func target(condition: Bool, name: String) -> Target.Dependency? {
        return (condition) ? (.target(name: name)) : (nil)
    }
}

