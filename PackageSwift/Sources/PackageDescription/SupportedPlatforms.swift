/*
 This source file is part of the Swift.org open source project

 Copyright (c) 2018-2020 Apple Inc. and the Swift project authors
 Licensed under Apache License v2.0 with Runtime Library Exception

 See http://swift.org/LICENSE.txt for license information
 See http://swift.org/CONTRIBUTORS.txt for Swift project authors
*/

/// A platform that usually corresponds to an operating system such as
/// iOS, macOS, or Linux.
public struct Platform: Encodable, Equatable {

    /// The name of the platform.
    fileprivate let name: String

    private init(name: String) {
        self.name = name
    }

    /// The macOS platform.
    public static let macOS: Platform = Platform(name: "macos")

    /// The iOS platform.
    public static let iOS: Platform = Platform(name: "ios")

    /// The tvOS platform.
    public static let tvOS: Platform = Platform(name: "tvos")

    /// The watchOS platform.
    public static let watchOS: Platform = Platform(name: "watchos")

    /// The Linux platform.
    public static let linux: Platform = Platform(name: "linux")

    /// The Windows platform.

    public static let windows: Platform = Platform(name: "windows")

    /// The Android platform.

    public static let android: Platform = Platform(name: "android")

    /// The WebAssembly System Interface platform.

    public static let wasi: Platform = Platform(name: "wasi")
}

/// A platform that the Swift package supports.
///
/// By default, the Swift Package Manager assigns a predefined minimum deployment
/// version for each supported platforms unless you configure supported platforms using the `platforms`
/// API. This predefined deployment version is the oldest deployment target
/// version that the installed SDK supports for a given platform. One exception
/// to this rule is macOS, for which the minimum deployment target version
/// starts from 10.10. Packages can choose to configure the minimum deployment
/// target version for a platform by using the APIs defined in this struct. The
/// Swift Package Manager emits appropriate errors when an invalid value is
/// provided for supported platforms, such as an empty array, multiple declarations
/// for the same platform, or an invalid version specification.
///
/// The Swift Package Manager emits an error if a dependency isn’t compatible
/// with the top-level package’s deployment version. The deployment
/// target of a package's dependencies must be lower than or equal to the top-level package's
/// deployment target version for a particular platform.
public struct SupportedPlatform: Encodable, Equatable {

    /// The platform.
    let platform: Platform

    /// The platform version.
    let version: String?

    /// Creates supported platform instance.
    init(platform: Platform, version: String? = nil) {
        self.platform = platform
        self.version = version
    }

    /// Configures the minimum deployment target version for the macOS platform.
    ///
    /// - Since: First available in PackageDescription 5.0
    ///
    /// - Parameter version: The minimum deployment target that the package supports.
    public static func macOS(_ version: SupportedPlatform.MacOSVersion) -> SupportedPlatform {
        return SupportedPlatform(platform: .macOS, version: version.version)
    }

    /// Configures the minimum deployment target version for the macOS platform
    /// using a version string.
    ///
    /// The version string must be a series of two or three dot-separated integers, such as `10.10` or `10.10.1`.
    ///
    /// - Since: First available in PackageDescription 5.0
    ///
    /// - Parameter versionString: The minimum deployment target as a string representation of two or three dot-separated integers, such as `10.10.1`.
    public static func macOS(_ versionString: String) -> SupportedPlatform {
        return SupportedPlatform(platform: .macOS, version: SupportedPlatform.MacOSVersion(string: versionString).version)
    }

    /// Configures the minimum deployment target version for the iOS platform.
    ///
    /// - Since: First available in PackageDescription 5.0
    ///
    /// - Parameter version: The minimum deployment target that the package supports.
    public static func iOS(_ version: SupportedPlatform.IOSVersion) -> SupportedPlatform {
        return SupportedPlatform(platform: .iOS, version: version.version)
    }

    /// Configures the minimum deployment target version for the iOS platform
    /// using a custom version string.
    ///
    /// The version string must be a series of two or three dot-separated integers, such as `8.0` or `8.0.1`.
    ///
    /// - Since: First available in PackageDescription 5.0
    ///
    /// - Parameter versionString: The minimum deployment target as a string representation of two or three dot-separated integers, such as `8.0.1`.
    public static func iOS(_ versionString: String) -> SupportedPlatform {
        return SupportedPlatform(platform: .iOS, version: SupportedPlatform.IOSVersion(string: versionString).version)
    }

    /// Configures the minimum deployment target version for the tvOS platform.
    ///
    /// - Since: First available in PackageDescription 5.0
    ///
    /// - Parameter version: The minimum deployment target that the package supports.
    public static func tvOS(_ version: SupportedPlatform.TVOSVersion) -> SupportedPlatform {
        return SupportedPlatform(platform: .tvOS, version: version.version)
    }

    /// Configures the minimum deployment target version for the tvOS platform
    /// using a custom version string.
    ///
    /// The version string must be a series of two or three dot-separated integers,such as `9.0` or `9.0.1`.
    ///
    /// - Since: First available in PackageDescription 5.0
    ///
    /// - Parameter versionString: The minimum deployment target as a string representation of two or three dot-separated integers, such as `9.0.1`.
    public static func tvOS(_ versionString: String) -> SupportedPlatform {
        return SupportedPlatform(platform: .tvOS, version: SupportedPlatform.TVOSVersion(string: versionString).version)
    }

    /// Configures the minimum deployment target version for the watchOS platform.
    ///
    /// - Since: First available in PackageDescription 5.0
    ///
    /// - Parameter version: The minimum deployment target that the package supports.
    public static func watchOS(_ version: SupportedPlatform.WatchOSVersion) -> SupportedPlatform {
        return SupportedPlatform(platform: .watchOS, version: version.version)
    }

    /// Configures the minimum deployment target version for the watchOS platform
    /// using a custom version string.
    ///
    /// The version string must be a series of two or three dot-separated integers, such as `2.0` or `2.0.1`.
    ///
    /// - Since: First available in PackageDescription 5.0
    ///
    /// - Parameter versionString: The minimum deployment target as a string representation of two or three dot-separated integers, such as `2.0.1`.
    public static func watchOS(_ versionString: String) -> SupportedPlatform {
        return SupportedPlatform(platform: .watchOS, version: SupportedPlatform.WatchOSVersion(string: versionString).version)
    }
}

/// An extension to the SupportedPlatform struct that defines major platform versions.
extension SupportedPlatform {
    
    /// The supported macOS version.
    public struct MacOSVersion: Encodable, AppleOSVersion {
        fileprivate static let name = "macOS"
        fileprivate static let minimumMajorVersion = 10

        /// The underlying version representation.
        let version: String

        fileprivate init(uncheckedVersion version: String) {
            self.version = version
        }

        /// The value that represents macOS 10.10.
        ///
        /// - Since: First available in PackageDescription 5.0
        public static let v10_10: MacOSVersion = .init(string: "10.10")

        /// The value that represents macOS 10.11.
        ///
        /// - Since: First available in PackageDescription 5.0
        public static let v10_11: MacOSVersion = .init(string: "10.11")

        /// The value that represents macOS 10.12.
        ///
        /// - Since: First available in PackageDescription 5.0
        public static let v10_12: MacOSVersion = .init(string: "10.12")

        /// The value that represents macOS 10.13.
        ///
        /// - Since: First available in PackageDescription 5.0
        public static let v10_13: MacOSVersion = .init(string: "10.13")

        /// The value that represents macOS 10.14.
        ///
        /// - Since: First available in PackageDescription 5.0
        public static let v10_14: MacOSVersion = .init(string: "10.14")

        /// The value that represents macOS 10.15.
        ///
        /// - Since: First available in PackageDescription 5.1

        public static let v10_15: MacOSVersion = .init(string: "10.15")

        /// The value that represents macOS 10.16, which has been
        /// replaced by the value for macOS 11.0.
        ///
        /// - Since: First available in PackageDescription 5.3

        public static let v10_16: MacOSVersion = .init(string: "11.0")

        /// The value that represents macOS 11.0.
        ///
        /// - Since: First available in PackageDescription 5.3

        public static let v11: MacOSVersion = .init(string: "11.0")
    }

    /// The supported tvOS version.
    public struct TVOSVersion: Encodable, AppleOSVersion {
        fileprivate static let name = "tvOS"
        fileprivate static let minimumMajorVersion = 9

        /// The underlying version representation.
        let version: String

        fileprivate init(uncheckedVersion version: String) {
            self.version = version
        }

        /// The value that represents tvOS 9.0.
        ///
        /// - Since: First available in PackageDescription 5.0
        public static let v9: TVOSVersion = .init(string: "9.0")

        /// The value that represents tvOS 10.0.
        ///
        /// - Since: First available in PackageDescription 5.0
        public static let v10: TVOSVersion = .init(string: "10.0")

        /// The value that represents tvOS 11.0.
        ///
        /// - Since: First available in PackageDescription 5.0
        public static let v11: TVOSVersion = .init(string: "11.0")

        /// The value that represents tvOS 12.0.
        ///
        /// - Since: First available in PackageDescription 5.0
        public static let v12: TVOSVersion = .init(string: "12.0")

        /// The value that represents tvOS 13.0.
        ///
        /// - Since: First available in PackageDescription 5.1

        public static let v13: TVOSVersion = .init(string: "13.0")
        
        /// The value that represents tvOS 14.0.
        ///
        /// - Since: First available in PackageDescription 5.3

        public static let v14: TVOSVersion = .init(string: "14.0")
    }

    /// The supported iOS version.
    public struct IOSVersion: Encodable, AppleOSVersion {
        fileprivate static let name = "iOS"
        fileprivate static let minimumMajorVersion = 2

        /// The underlying version representation.
        let version: String

        fileprivate init(uncheckedVersion version: String) {
            self.version = version
        }

        /// The value that represents iOS 8.0.
        ///
        /// - Since: First available in PackageDescription 5.0
        public static let v8: IOSVersion = .init(string: "8.0")

        /// The value that represents iOS 9.0.
        ///
        /// - Since: First available in PackageDescription 5.0
        public static let v9: IOSVersion = .init(string: "9.0")

        /// The value that represents iOS 10.0.
        ///
        /// - Since: First available in PackageDescription 5.0
        public static let v10: IOSVersion = .init(string: "10.0")

        /// The value that represents iOS 11.0.
        ///
        /// - Since: First available in PackageDescription 5.0
        public static let v11: IOSVersion = .init(string: "11.0")

        /// The value that represents iOS 12.0.
        ///
        /// - Since: First available in PackageDescription 5.0
        public static let v12: IOSVersion = .init(string: "12.0")

        /// The value that represents iOS 13.0.
        ///
        /// - Since: First available in PackageDescription 5.1

        public static let v13: IOSVersion = .init(string: "13.0")

        /// The value that represents iOS 14.0.
        ///
        /// - Since: First available in PackageDescription 5.3

        public static let v14: IOSVersion = .init(string: "14.0")
    }

    /// The supported watchOS version.
    public struct WatchOSVersion: Encodable, AppleOSVersion {
        fileprivate static let name = "watchOS"
        fileprivate static let minimumMajorVersion = 2

        /// The underlying version representation.
        let version: String

        fileprivate init(uncheckedVersion version: String) {
            self.version = version
        }

        /// The value that represents watchOS 2.0.
        ///
        /// - Since: First available in PackageDescription 5.0
        public static let v2: WatchOSVersion = .init(string: "2.0")

        /// The value that represents watchOS 3.0.
        ///
        /// - Since: First available in PackageDescription 5.0
        public static let v3: WatchOSVersion = .init(string: "3.0")

        /// The value that represents watchOS 4.0.
        ///
        /// - Since: First available in PackageDescription 5.0
        public static let v4: WatchOSVersion = .init(string: "4.0")

        /// The value that represents watchOS 5.0.
        ///
        /// - Since: First available in PackageDescription 5.0
        public static let v5: WatchOSVersion = .init(string: "5.0")

        /// The value that represents watchOS 6.0.
        ///
        /// - Since: First available in PackageDescription 5.1

        public static let v6: WatchOSVersion = .init(string: "6.0")

        /// The value that represents watchOS 7.0.
        ///
        /// - Since: First available in PackageDescription 5.3

        public static let v7: WatchOSVersion = .init(string: "7.0")
    }
}

fileprivate protocol AppleOSVersion {
    static var name: String { get }
    static var minimumMajorVersion: Int { get }
    init(uncheckedVersion: String)
}

struct StringError: Error, CustomStringConvertible {
    var error: String

    init(_ error: String) {
        self.error = error
    }

    var description: String { error }
}

fileprivate extension AppleOSVersion {

    static func validateVersion(_ string: String) throws {
        let components = string.split(separator: ".", omittingEmptySubsequences: false)

        func error(_ error: String) throws {
            throw StringError("invalid \(Self.name) version \(string); \(error)")
        }

        for (idx, component) in components.enumerated() {
            if component.isEmpty {
                try error("found an empty component")
            }

            if idx < 2 {
                if UInt(component) == nil {
                    try error("\(component) should be a positive integer")
                }
            }
        }

        if (UInt(components[0]) ?? 0) < Self.minimumMajorVersion {
            try error("the minimum major version should be \(Self.minimumMajorVersion)")
        }
    }

    init(string: String) {
        do {
            try Self.validateVersion(string)
        } catch {
            errors.append("\(error)")
        }

        self.init(uncheckedVersion: string)
    }
}
