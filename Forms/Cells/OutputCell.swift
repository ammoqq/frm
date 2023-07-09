//
//  OutputCell.swift
//  AviobookUI
//
//  Created by Dries Steegmans on 11/10/2018.
//

import AviobookUtility
import EasyPeasy
import Foundation

public class OutputCell: FormTableCell {
    let titleLabel = UILabel()
    let valueLabel = UILabel()

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabels()
    }

    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setupLabels() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)

        titleLabel.easy.layout(CenterY(), Left(AviobookStyle.Offset.small))
        titleLabel.font = UIFont.bold(.small)
        titleLabel.textColor = AviobookColor.white.clouds

        valueLabel.easy.layout(CenterY(), Right(AviobookStyle.Offset.small))
        valueLabel.font = UIFont.normal
        valueLabel.textColor = AviobookColor.white
    }

    public func update(state: LabelFieldState) {
        titleLabel.text = state.titleText
        valueLabel.text = state.stringValue
        isHidden = state.isHidden
        height = state.isHidden ? 0 : 41
    }

    public func update(state: AttributedLabelFieldState) {
        titleLabel.text = state.titleText
        valueLabel.attributedText = state.attributedStringValue
        isHidden = state.isHidden
        height = state.isHidden ? 0 : 41
    }
}
