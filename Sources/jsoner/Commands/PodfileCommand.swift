//
// Copyright © 2020 Rosberry. All rights reserved.
//

import Foundation
import ArgumentParser

final class PodfileCommand: ParsableCommand {

    static let configuration: CommandConfiguration = .init(commandName: "podfile")

    @Argument
    var podfilePath: String

    func run() throws {
        let shell = Shell()
        let output: Shell.IO = try shell("pod", "ipc", "podfile-json", podfilePath)
        print(output.stdOut)
    }
}
