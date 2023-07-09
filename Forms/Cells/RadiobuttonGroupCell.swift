//
//  RadiobuttonGroupCell.swift
//  AviobookUI
//
//  Created by Dries Steegmans on 16/10/2018.
//

import EasyPeasy
import Foundation

class RadiobuttonGroupCell: FormTableCell {
    let titleLabel = UILabel()
    var buttonLabels = [UILabel]()
    var radioButtons = [RadioButton]()

    public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, amount: Int) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        height = CGFloat(40 * amount)
        contentView.easy.layout(Height(height))
        for _ in 1...amount {
            let label = UILabel()
            let radioButton = RadioButton()
            buttonLabels.append(label)
            radioButtons.append(radioButton)
        }
        contentView.addSubview(titleLabel)
        contentView.addSubviews(buttonLabels)
        contentView.addSubviews(radioButtons)

        setupTitleLabel()
        setupButtonLabels()
        setupRadioButtons()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTitleLabel() {
        titleLabel.easy.layout(Left(15), Top(10))
        titleLabel.font = UIFont.bold(.small)
        titleLabel.textColor = AviobookColor.white.clouds
    }

    private func setupButtonLabels() {
        for (index, label) in buttonLabels.enumerated() {
            let top = index == 0 ? Top(10) : Top(18.5).to(buttonLabels[index - 1], .bottom)
            label.easy.layout(Right(10), top)
            label.font = UIFont.normal
            label.textColor = AviobookColor.white
        }
    }

    private func setupRadioButtons() {
        for (index, button) in radioButtons.enumerated() {
            let top = index == 0 ? Top(10) : Top(-2).to(buttonLabels[index], .top)
            button.easy.layout(Right(116.5), top)
            button.isSelected = false
            button.accessibilityIdentifier = "radio\(index)"

            button.onSelect = { [weak self] radio in
                guard let radioButtons = self?.radioButtons else { return }
                if radio.isSelected { return }
                radioButtons.forEach { button in
                    if button !== radio {
                        button.isSelected = false
                    }
                }
                radio.isSelected = !radio.isSelected
            }
        }
    }
}
