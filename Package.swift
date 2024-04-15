// swift-tools-version:5.3
/*
 * Copyright (c) WEX, Inc. All rights reserved.
 *
 * Owned, written, and maintained by WEX Small Business.
 * Author: Kyle Beard
 */

import PackageDescription
import Foundation

let package = Package(
    name: "Sentry",
    platforms: [.iOS(.v11), .macOS(.v10_13), .tvOS(.v11), .watchOS(.v4)],
    products: [
        .library(name: "Sentry", targets: ["Sentry"]),
        .library(name: "Sentry-Dynamic", targets: ["Sentry-Dynamic"]),
        .library(name: "SentrySwiftUI", targets: ["Sentry", "SentrySwiftUI"])
    ],
    targets: [
        .binaryTarget(
                    name: "Sentry",
                    url: "https://github.com/getsentry/sentry-cocoa/releases/download/8.24.0/Sentry.xcframework.zip",
                    checksum: isRemote ? Checksum.Remote.sentry.rawValue : Checksum.Local.sentry.rawValue
                ),
        .binaryTarget(
                    name: "Sentry-Dynamic",
                    url: "https://github.com/getsentry/sentry-cocoa/releases/download/8.24.0/Sentry-Dynamic.xcframework.zip",
                    checksum: isRemote ? Checksum.Remote.sentryDynamic.rawValue : Checksum.Local.sentryDynamic.rawValue
                ),
        .target ( name: "SentrySwiftUI",
                  dependencies: ["Sentry", "SentryInternal"],
                  path: "Sources/SentrySwiftUI",
                  exclude: ["SentryInternal/", "module.modulemap"],
                  linkerSettings: [
                     .linkedFramework("Sentry")
                  ]
                ),
        .target( name: "SentryInternal",
                 path: "Sources/SentrySwiftUI",
                 sources: [
                    "SentryInternal/"
                 ],
                 publicHeadersPath: "SentryInternal/"
               )
    ],
    cxxLanguageStandard: .cxx14
)

let isRemote = getenv("IGNORE_WEX_CHECKSUM") != nil
 
enum Checksum {
    static let sentry = "Sentry"
    static let sentryDynamic = "Sentry-Dynamic"

    /// This checksum corresponds to the WEX Netskope fuckery that occurs when they unzip and rezip files -_-
    enum Local: String {
        case sentry = "4f89b90200e9b7e38fc5a896e9160307f54565755cbf7085d5ff7c79f7ac77bc"
        case sentryDynamic = "048dcccf68c38430e658ff97f28b25c7512d6ed95d1ec4deebc2df551494b028"
    }

    /// This corresponds to the checksum that everyone else more fortunate to not encounter Netskope would see.
    enum Remote: String {
        case sentry = "e0348b8e112bcc3864831e7a631478c2028335615f4d88ef5a77c6423b34c7f5"
        case sentryDynamic = "1dea62b0c53fc4ca2fd475808a46b1978ad75f19c4a4b8f56fa3c564c000d33e"
    }
}
