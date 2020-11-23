//
// Copyright © 2020 Rosberry. All rights reserved.
//

import Foundation
import ArgumentParser

final class JSONer: ParsableCommand {
    static let configuration: CommandConfiguration = .init(subcommands: [PackageSwiftCommand.self,
                                                                         CartfileCommand.self,
                                                                         PodfileCommand.self])
}