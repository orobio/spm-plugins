// KernelInfo.swift
//
// Simple example of a plugin that can provide Package.manifest with dynamic data.
// The plugin provides information about whether the kernel supports IPv4/IPv6.
// For this example the values are hardcoded.
//

public struct KernelInfo {
    static public var hasIpv4: Bool {
        return true
    }

    static public var hasIpv6: Bool {
        return false
    }
}

