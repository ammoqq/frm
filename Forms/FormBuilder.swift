//
//  FormBuilder.swift
//  AviobookUtility
//
//  Created by Artur Osinski on 08/08/2018.
//

import AviobookUtility
import Foundation

public final class TargetAction {
    let execute: () -> Void

    public init(_ execute: @escaping () -> Void) {
        self.execute = execute
    }

    @objc
    public func action(_: Any) {
        execute()
    }
}

public class FormBuilder {
    public class func textView<State: AviobookUtility.Validatable>(title _: String, keyPath: WritableKeyPath<State, TextFieldState>) -> Rendered<State, FormTableCell> {
        return { context in
            let cell = TextViewCell(style: .default, reuseIdentifier: nil)
            let changed = { text in
                context.change(keyPath) {
                    $0[keyPath: keyPath].stringValue = text
                }
            }
            cell.textChanged = changed

            return RenderedElement(element: cell, strongReferences: [changed], update: { state in
                let field = state[keyPath: keyPath]
                cell.configure(field: field)
            })
        }
    }

    public class func infoTextView<State: AviobookUtility.Validatable>(title _: String, keyPath: WritableKeyPath<State, TextFieldState>) -> Rendered<State, FormTableCell> {
        return { _ in
            let cell = InfoTextViewCell(style: .default, reuseIdentifier: nil)
            return RenderedElement(element: cell, strongReferences: [], update: { state in
                let field = state[keyPath: keyPath]
                cell.configure(field: field)
            })
        }
    }

    public class func selectableField<State: AviobookUtility.Validatable>(title _: String, keyPath: WritableKeyPath<State, SelectableFieldState>) -> Rendered<State, FormTableCell> {
        return { context in
            let cell = SelectableCell(style: .default, reuseIdentifier: nil)
            cell.configure(field: context.state[keyPath: keyPath])
            cell.didSelect = {
                context.openModalSelector(keyPath)
            }

            return RenderedElement(element: cell, strongReferences: [], update: { state in
                let field = state[keyPath: keyPath]
                cell.configure(field: field)
            })
        }
    }

    public class func radioButtonField<State: AviobookUtility.Validatable>(keyPath: WritableKeyPath<State, RadioButtonGroupState>, amount: Int) -> Rendered<State, FormTableCell> {
        return { context in
            let cell = RadiobuttonGroupCell(style: .default, reuseIdentifier: nil, amount: amount)

            let changed = TargetAction {
                context.change(nil) {
                    for index in 0..<$0[keyPath: keyPath].buttonStates.count {
                        $0[keyPath: keyPath].buttonStates[index] = cell.radioButtons[index].isSelected
                    }
                }
            }

            cell.radioButtons.forEach { button in
                button.addTarget(changed, action: #selector(TargetAction.action(_:)), for: .touchUpInside)
            }

            return RenderedElement(element: cell, strongReferences: [changed], update: { state in
                let radioButtonGroupState = state[keyPath: keyPath]
                cell.titleLabel.text = radioButtonGroupState.titleText
                for (index, label) in cell.buttonLabels.enumerated() {
                    label.text = radioButtonGroupState.stringValues[index]
                }
                for (index, button) in cell.radioButtons.enumerated() {
                    button.isSelected = radioButtonGroupState.buttonStates[index]
                }
            })
        }
    }

    public class func horizontalRadioButtonField<State: AviobookUtility.Validatable>(keyPath: WritableKeyPath<State, RadioButtonGroupState>, amount: Int) -> Rendered<State, FormTableCell> {
        return { context in
            let cell = RadioButtonGroupTableViewCell(style: .default, reuseIdentifier: nil, amount: amount, radioButtonOrientation: .horizontal)

            let changed = TargetAction {
                context.change(nil) {
                    for index in $0[keyPath: keyPath].buttonStates.indices {
                        $0[keyPath: keyPath].buttonStates[index] = cell.radioButtons[index].isSelected
                    }
                }
            }

            cell.radioButtons.forEach { button in
                button.addTarget(changed, action: #selector(TargetAction.action(_:)), for: .touchUpInside)
            }

            return RenderedElement(element: cell, strongReferences: [changed], update: { state in
                let radioButtonGroupState = state[keyPath: keyPath]
                cell.update(state: radioButtonGroupState)
            })
        }
    }

    public class func labelField<State: AviobookUtility.Validatable>(keyPath: WritableKeyPath<State, LabelFieldState>) -> Rendered<State, FormTableCell> {
        return { _ in
            let cell = OutputCell(style: .default, reuseIdentifier: nil)

            return RenderedElement(element: cell, strongReferences: [], update: { state in
                let labelFieldState = state[keyPath: keyPath]
                cell.update(state: labelFieldState)
            })
        }
    }

    public class func labelFieldWithoutTitle<State: AviobookUtility.Validatable>(keyPath: WritableKeyPath<State, LabelFieldState>) -> Rendered<State, FormTableCell> {
        return { _ in
            let cell = OutputTextCell(style: .default, reuseIdentifier: nil)

            return RenderedElement(element: cell, strongReferences: [], update: { state in
                let labelFieldState = state[keyPath: keyPath]
                cell.update(state: labelFieldState)
            })
        }
    }

    public class func attributedLabelField<State: AviobookUtility.Validatable>(keyPath: WritableKeyPath<State, AttributedLabelFieldState>) -> Rendered<State, FormTableCell> {
        return { _ in
            let cell = OutputCell(style: .default, reuseIdentifier: nil)

            return RenderedElement(element: cell, strongReferences: [], update: { state in
                let attributedLabelFieldState = state[keyPath: keyPath]
                cell.update(state: attributedLabelFieldState)
            })
        }
    }

    public class func dualLabelField<State: AviobookUtility.Validatable>(keyPath: WritableKeyPath<State, DualLabelFieldState>) -> Rendered<State, FormTableCell> {
        return { _ in
            let cell = DualOutputCell(style: .default, reuseIdentifier: nil)

            return RenderedElement(element: cell, strongReferences: [], update: { state in
                let labelFieldState = state[keyPath: keyPath]
                cell.update(data: labelFieldState)
            })
        }
    }

    public class func labelIconField<State: AviobookUtility.Validatable>(keyPath: WritableKeyPath<State, LabelIconFieldState>) -> Rendered<State, FormTableCell> {
        return { _ in
            let cell = OutputIconCell(style: .default, reuseIdentifier: nil)

            return RenderedElement(element: cell, strongReferences: [], update: { state in
                let labelFieldState = state[keyPath: keyPath]
                cell.configure(field: labelFieldState)
            })
        }
    }

    public class func textField<State: AviobookUtility.Validatable>(keyPath: WritableKeyPath<State, TextFieldState>, textFieldWidth: CGFloat? = 92) -> Rendered<State, FormTableCell> {
        return { context in
            let cell = TextFieldCell(style: .default, reuseIdentifier: nil, textFieldWidth: textFieldWidth)
            let textFieldState = context.state[keyPath: keyPath]
            cell.configure(field: textFieldState)

            let changed = TargetAction {
                context.change(keyPath) {
                    var futureState = $0
                    futureState[keyPath: keyPath].stringValue = cell.textField?.text

                    if futureState[keyPath: keyPath].satisfiesPreConditions() {
                        $0[keyPath: keyPath].stringValue = cell.textField?.text
                        $0[keyPath: keyPath].inputState = InputState.userEdited.rawValue
                    } else {
                        cell.textField?.text = $0[keyPath: keyPath].stringValue
                    }
                }
            }

            let editingFinished = TargetAction {
                context.changeFinished(keyPath) {
                    $0[keyPath: keyPath].stringValue = cell.textField?.text
                }
            }

            cell.textField?.textField.addTarget(changed, action: #selector(TargetAction.action(_:)), for: .editingChanged)
            cell.textField?.textField.addTarget(editingFinished, action: #selector(TargetAction.action(_:)), for: .editingDidEnd)

            return RenderedElement(element: cell, strongReferences: [changed, editingFinished], update: { state in
                let textFieldState = state[keyPath: keyPath]
                cell.configure(field: textFieldState)
            })
        }
    }

    public class func dualTextField<State: AviobookUtility.Validatable>(keyPath: WritableKeyPath<State, DualLabelIconFieldState>) -> Rendered<State, FormTableCell> {
        return { context in
            let cell = DualLabelFieldCell(style: .default, reuseIdentifier: nil)
            let fieldState = context.state[keyPath: keyPath]
            cell.configure(field: fieldState)

            return RenderedElement(element: cell, strongReferences: [], update: { state in
                let fieldState = state[keyPath: keyPath]
                cell.configure(field: fieldState)
            })
        }
    }

    public class func controlCell<State>(title _: String, control: @escaping Rendered<State, UIView>) -> Rendered<State, FormTableCell> {
        return { context in
            let cell = FormTableCell(style: .default, reuseIdentifier: nil)
            let renderedControl = control(context)

            cell.contentView.addSubview(renderedControl.element)
            cell.contentView.addConstraints([
                renderedControl.element.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                renderedControl.element.trailingAnchor.constraint(equalTo: cell.contentView.layoutMarginsGuide.trailingAnchor)
            ])

            return RenderedElement(element: cell, strongReferences: renderedControl.strongReferences, update: renderedControl.update)
        }
    }

    public class func tableSection<State>(_ cells: [Rendered<State, FormTableCell>], headerTitle: String? = nil, footerTitle: KeyPath<State, String?>? = nil) -> RenderedTableSection<State> {
        return { context in
            let renderedCells = cells.map { $0(context) }
            let strongReferences = renderedCells.flatMap { $0.strongReferences }
            var formHeaderCell: FormHeaderCell?

            if headerTitle != nil {
                formHeaderCell = FormHeaderCell(reuseIdentifier: nil)
            }

            let section = TableSection(cells: renderedCells.map { $0.element }, header: formHeaderCell, roundedCorners: true)
            let update: (State) -> Void = { [weak footerTitle] state in
                for renderedSection in renderedCells {
                    renderedSection.update(state)
                }
                if let headerTitleUnwrapped = headerTitle {
                    section.headerTitle = headerTitleUnwrapped
                }
                if let footerKp = footerTitle {
                    section.footerTitle = state[keyPath: footerKp]
                }
            }
            return RenderedElement(element: section, strongReferences: strongReferences, update: update)
        }
    }

    public class func tableSections<State>(_ sections: [RenderedTableSection<State>]) -> TableForm<State> {
        return { context in
            let renderedSections = sections.map { $0(context) }
            let strongReferences = renderedSections.flatMap { $0.strongReferences }
            let update: (State) -> Void = { state in
                for renderedSection in renderedSections {
                    renderedSection.update(state)
                }
            }
            return RenderedElement(element: renderedSections.map { $0.element }, strongReferences: strongReferences, update: update)
        }
    }
}
