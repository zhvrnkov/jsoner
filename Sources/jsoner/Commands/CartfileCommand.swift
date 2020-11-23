//
// Copyright © 2020 Rosberry. All rights reserved.
//

import Foundation
import ArgumentParser
import CartfileParser

final class CartfileCommand: ParsableCommand {

    enum Error: Swift.Error {
        case badPath
    }

    static let configuration: CommandConfiguration = .init(commandName: "cartfile")

    @Argument
    var cartfilePath: String

    func run() throws {
        let url = URL(fileURLWithPath: cartfilePath)
        let cartfile = CodableCartfile(cartfile: try Cartfile.from(file: url).get())
        let jsonData = try JSONEncoder().encode(cartfile)
        print(String(data: jsonData, encoding: .utf8) ?? "")
    }
}
