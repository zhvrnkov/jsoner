//
// Copyright © 2020 Rosberry. All rights reserved.
//

import Foundation
import CartfileParser

struct CodableCartfile: Codable {

    struct Dependency: Codable {

        enum Kind: String, Codable {
            case gitHub
            case git
            case binary

            init(_ dependency: CartfileParser.Dependency) {
                switch dependency {
                case .gitHub:
                    self = .gitHub
                case .git:
                    self = .git
                case .binary:
                    self = .binary
                }
            }
        }

        let kind: Kind
        let identifier: String

        init(_ dependency: CartfileParser.Dependency) {
            kind = .init(dependency)
            identifier = dependency.name
        }
    }

    struct Version: Codable {

        enum Kind: String, Codable {
            case any
            case atLeast
            case compatibleWith
            case exactly
            case gitReference
        }

        let kind: Kind
        let value: String

        init?(_ versionSpecifier: CartfileParser.VersionSpecifier) {
            switch versionSpecifier {
            case .any:
                return nil
            case let .atLeast(semanticVersion):
                kind = .atLeast
                value = "\(semanticVersion)"
            case let .compatibleWith(semanticVersion):
                kind = .compatibleWith
                value = "\(semanticVersion)"
            case let .exactly(semanticVersion):
                kind = .exactly
                value = "\(semanticVersion)"
            case let .gitReference(value):
                kind = .gitReference
                self.value = value
            }
        }
    }
    
    struct Item: Codable {
        let dependency: Dependency
        let version: Version?
    }

    let items: [Item]

    init(cartfile: Cartfile) {
        items = cartfile.dependencies.map { (dependency, version) in
            Item(dependency: Dependency(dependency), version: Version(version))
        }
    }
}