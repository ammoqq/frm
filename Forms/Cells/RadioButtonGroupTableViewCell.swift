//
//  RadioButtonGroupTableViewCell.swift
//  AviobookUI
//
//  Created by Jeroen Abrahams on 06/02/2020.
//

import AviobookUtility
import EasyPeasy
import Foundation

class RadioButtonGroupTableViewCell: FormTableCell {
    enum RadioButtonOrientation {
        case horizontal, vertical
    }

    private let amount: Int
    private let radioButtonOrientation: RadioButtonOrientation
    private let radioButtonsView = UIStackView()

    private(set) var radioButtonItemViews: [RadioButtonItemView] = []
    let titleLabel = UILabel()
    var radioButtons: [RadioButton] {
        return radioButtonItemViews.map { $0.radioButton }
    }

    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, amount: Int, radioButtonOrientation: RadioButtonOrientation) {
        self.radioButtonOrientation = radioButtonOrientation
        self.amount = amount
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupContentViewLayout()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupContentViewLayout() {
        radioButtonsView.alignment = .center
        if radioButtonOrientation == .horizontal {
            radioButtonsView.axis = .horizontal
            radioButtonsView.distribution = .fillProportionally
            height = 40
        } else {
            radioButtonsView.axis = .vertical
            height = CGFloat(40 * amount)
        }
        contentView.easy.layout(Height(height))

        setupTitleLabel()
        setupRadioButtons()
    }

    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.easy.layout(Left(AviobookStyle.Offset.medium), Top(AviobookStyle.Offset.small))
        titleLabel.font = UIFont.bold(.small)
        titleLabel.textColor = AviobookColor.white.clouds
    }

    func update(state: RadioButtonGroupState) {
        titleLabel.text = state.titleText
        for (index, radioButtomItem) in radioButtonItemViews.enumerated() {
            radioButtomItem.update(text: state.stringValues[index], isSelected: state.buttonStates[index])
        }
    }

    private func setupRadioButtons() {
        contentView.addSubview(radioButtonsView)
        radioButtonsView.easy.layout(Left().to(titleLabel), Right(), Top(), Bottom())

        guard amount > 0 else { return }

        let sequence = (0...(amount - 1))
        for index in sequence {
            let radioButtonItemView = RadioButtonItemView(labelWidth: 25)
            radioButtonItemViews.append(radioButtonItemView)

            radioButtonItemViews[index].radioButton.accessibilityIdentifier = "radio\(index)"
            radioButtonItemViews[index].radioButton.onSelect = { [weak self] radioButton in
                self?.select(radioButton: radioButton)
            }
            radioButtonsView.addArrangedSubview(radioButtonItemViews[index])
        }
    }

    private func select(radioButton: RadioButton) {
        guard !radioButton.isSelected else {
            return
        }
        radioButtonItemViews.forEach { radioButtonItem in
            if radioButtonItem.radioButton !== radioButton {
                radioButtonItem.radioButton.isSelected = false
            }
        }
        radioButton.isSelected = !radioButton.isSelected
    }
}
