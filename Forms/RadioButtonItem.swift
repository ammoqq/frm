//
//  RadiobuttonItem.swift
//  AviobookUI
//
//  Created by Jeroen Abrahams on 06/02/2020.
//

import EasyPeasy
import Foundation

public class RadioButtonItemView: UIView {
    var buttonLabel: UILabel
    var radioButton: RadioButton
    private let labelWidth: CGFloat?

    init(labelWidth: CGFloat? = nil) {
        self.labelWidth = labelWidth

        buttonLabel = UILabel()
        radioButton = RadioButton()
        radioButton.isSelected = false

        super.init(frame: .zero)
        setup()
    }

    private func setup() {
        easy.layout(Height(40))

        addSubview(buttonLabel)
        addSubview(radioButton)

        radioButton.easy.layout(Left(AviobookStyle.Offset.small), Top(), Bottom())
        if let labelWidth = labelWidth {
            buttonLabel.easy.layout(Width(labelWidth))
        }
        buttonLabel.easy.layout(
            Left(AviobookStyle.Offset.small).to(radioButton),
            Right(AviobookStyle.Offset.xSmall),
            Top(),
            Bottom())

        buttonLabel.font = UIFont.normal
        buttonLabel.textColor = AviobookColor.white
        buttonLabel.textAlignment = .left
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(text: String) {
        buttonLabel.text = text
    }

    func update(text: String, isSelected: Bool) {
        update(text: text)
        radioButton.isSelected = isSelected
    }
}
