//
// Created by Marcin Dziennik on 2018-12-18.
//

import AviobookUtility
import Foundation

public struct RenderingContext<State> {
    public typealias ChangeClosure = (WritableKeyPath<State, TextFieldState>?, (inout State) -> Void) -> Void
    public let state: State
    public let change: ChangeClosure
    public let changeFinished: ChangeClosure
    public let openModalSelector: (WritableKeyPath<State, SelectableFieldState>) -> Void
    public let actions: [ActionIdentifier: Any]

    public init(
        state: State,
        change: @escaping ChangeClosure,
        changeFinished: @escaping ChangeClosure,
        openModalSelector: @escaping (WritableKeyPath<State, SelectableFieldState>) -> Void,
        actions: [ActionIdentifier: Any] = [:]) {
        self.state = state
        self.change = change
        self.changeFinished = changeFinished
        self.openModalSelector = openModalSelector
        self.actions = actions
    }
}
