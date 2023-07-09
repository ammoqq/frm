//
//  DualLabelFieldState.swift
//  AviobookUI
//
//  Created by Jeroen Abrahams on 12/02/2020.
//

import AviobookUtility
import Foundation

public struct DualLabelFieldState: ValidatableField {
    public var identifier: String = ""
    public var titleText: String = ""
    public var stringValue: String?
    public var secondTitleText: String = ""
    public var secondStringValue: String?
    public var isHidden = false
    public var rules: [Rule] = []

    public init(rules: [Rule]) {
        self.rules = rules
    }
}
