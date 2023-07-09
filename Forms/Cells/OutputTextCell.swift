//
//  OutputTextCell.swift
//  AviobookUI
//
//  Created by Jeroen Abrahams on 01/04/2020.
//

import EasyPeasy
import Foundation

import AviobookUtility

public class OutputTextCell: FormTableCell {
    let valueLabel = UILabel()

    public override var height: CGFloat {
        get {
            /// valueLabel with custom height + padding + adding 1 (without adding 1 in the height the amount of lines shown in the cell is incorrect)
            return valueLabel.intrinsicContentSize.height + (AviobookStyle.Offset.small * 2) + 1
        }
        set {}
    }

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(valueLabel)
        valueLabel.numberOfLines = 0
        valueLabel.font = UIFont.default.font(size: .small, weight: .regular)
        valueLabel.textColor = AviobookColor.Text.active
        valueLabel.easy.layout(Edges(AviobookStyle.Offset.small))
    }

    func update(state: LabelFieldState) {
        valueLabel.text = state.stringValue
        valueLabel.sizeToFit()
        invalidateIntrinsicContentSize()
        layoutIfNeeded()
    }

    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
