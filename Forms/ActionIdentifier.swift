//
// Created by Marcin Dziennik on 2018-12-18.
//

import Foundation

public struct ActionIdentifier: Hashable {
    public private(set) var identifier: String

    public init(string: String) {
        identifier = string
    }

    public var hashValue: Int {
        return identifier.hashValue
    }

    public static func == (lhs: ActionIdentifier, rhs: ActionIdentifier) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
