//
// Copyright © 2020 Rosberry. All rights reserved.
//

import Foundation
import ArgumentParser

final class PackageSwiftCommand: ParsableCommand {

    static let configuration: CommandConfiguration = .init(commandName: "package-swift")

    @Argument
    var packageSwiftPath: String
    private let packageDescriptionScriptPath: String = "\(NSHomeDirectory())/.jsoner/PackageDescription/main"

    func run() throws {
        let shell = Shell()
        let output: Shell.IO = try shell(packageDescriptionScriptPath, packageSwiftPath)
        print(output.stdOut)
    }
}
