//
// Copyright © 2020 Rosberry. All rights reserved.
//

import Foundation
import XCTest
import CartfileParser

final class CartfileParserTest: XCTestCase {

    private let cartfile: String = #"""
                                   github "ReactiveCocoa/ReactiveCocoa" >= 2.3.1
                                   github "Mantle/Mantle" ~> 1.0

                                   # here is a comment
                                   github "jspahrsummers/libextobjc" == 0.4.1# With intra-line comment without space after version
                                   github "jspahrsummers/xcconfigs" # here is an intra-line comment

                                   github "ExampleOrg/ExamplePrj1" >= 3.0.2-pre # With intra-line comment after version
                                   github "ExampleOrg/ExamplePrj2" == 3.0.2+build # With intra-line comment after version
                                   github "ExampleOrg/ExamplePrj3" == 3.0.2 # With intra-line comment after version

                                   github "ExampleOrg/ExamplePrj4" "release#2" # this is not a SemVer

                                   # name with .git suffix
                                   github "danielgindi/ios-charts.git"

                                   # GitHub Enterprise
                                   github "https://enterprise.local/ghe/desktop/git-error-translations"

                                   git "https://enterprise.local/desktop/git-error-translations2.git" "development"

                                   """#

    // the origin of this test can be found here:
    // https://github.com/Carthage/Carthage/blob/master/Tests/CarthageKitTests/CartfileSpec.swift
    func testCartfileParsing() {
        guard let cartfile = try? Cartfile.from(string: self.cartfile).get() else {
            XCTFail("bar TestCartfile")
            return
        }

        let reactiveCocoa = Dependency.gitHub("ReactiveCocoa/ReactiveCocoa")
        let mantle = Dependency.gitHub("Mantle/Mantle")
        let libextobjc = Dependency.gitHub("jspahrsummers/libextobjc")
        let xcconfigs = Dependency.gitHub("jspahrsummers/xcconfigs")
        let iosCharts = Dependency.gitHub("danielgindi/ios-charts.git")
        let errorTranslations = Dependency.gitHub("https://enterprise.local/ghe/desktop/git-error-translations")
        let errorTranslations2 = Dependency.git(URL(string: "https://enterprise.local/desktop/git-error-translations2.git"))
        let example1 = Dependency.gitHub("ExampleOrg/ExamplePrj1")
        let example2 = Dependency.gitHub("ExampleOrg/ExamplePrj2")
        let example3 = Dependency.gitHub("ExampleOrg/ExamplePrj3")
        let example4 = Dependency.gitHub("ExampleOrg/ExamplePrj4")

        let expectedDependencies: [Dependency: VersionSpecifier] = [
            reactiveCocoa: .atLeast(SemanticVersion(2, 3, 1)),
            mantle: .compatibleWith(SemanticVersion(1, 0, 0)),
            libextobjc: .exactly(SemanticVersion(0, 4, 1)),
            xcconfigs: .any,
            iosCharts: .any,
            errorTranslations: .any,
            errorTranslations2: .gitReference("development"),
            example1: .atLeast(SemanticVersion(3, 0, 2, preRelease: "pre")),
            example2: .exactly(SemanticVersion(3,
                                               0,
                                               2,
                                               preRelease: nil,
                                               buildMetadata: "build")),
            example3: .exactly(SemanticVersion(3, 0, 2)),
            example4: .gitReference("release#2")
        ]
        XCTAssertEqual(cartfile.dependencies, expectedDependencies)
    }
}