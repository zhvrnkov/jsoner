//
// Copyright © 2020 Rosberry. All rights reserved.
//

import Foundation
import ArgumentParser

final class JSONer: ParsableCommand {
    static let configuration: CommandConfiguration = .init(version: "0.0.1",
                                                           subcommands: [PackageSwiftCommand.self,
                                                                         CartfileCommand.self,
                                                                         PodfileCommand.self])
}
