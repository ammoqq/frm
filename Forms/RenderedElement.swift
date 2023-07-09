//
//  RenderedElement.swift
//  AviobookUtility
//
//  Created by Artur Osinski on 09/08/2018.
//

import AviobookUtility
import Foundation

public struct RenderedElement<Element, State> {
    public var element: Element
    public var strongReferences: [Any]
    public var update: (State) -> Void

    public init(element: Element, strongReferences: [Any], update: @escaping ((State) -> Void)) {
        self.element = element
        self.strongReferences = strongReferences
        self.update = update
    }
}
