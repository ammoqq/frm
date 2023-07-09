//
import AviobookUtility
import EasyPeasy
//  LabelCell.swift
//  AviobookUI
//
//  Created by Artur Osinski on 19/10/2018.
//
import Foundation

public class LabelCell: FormTableCell {
    let titleLabel = UILabel()
    let valueLabel = UILabel()
    let subValueLabel = UILabel()

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.add(subview: titleLabel)
        titleLabel.easy.layout(CenterY(), Left(15))
        titleLabel.font = UIFont.bold(.small)
        titleLabel.textColor = AviobookColor.white.clouds

        contentView.add(subview: valueLabel)
        valueLabel.easy.layout(
            CenterY().when { [weak self] in
                self?.subValueLabel.text == nil
            },
            CenterY(-6).when { [weak self] in
                self?.subValueLabel.text != nil
            },
            Right(9),
            Left(120))
        valueLabel.font = UIFont.normal
        valueLabel.textColor = AviobookColor.white
        valueLabel.textAlignment = .right

        contentView.add(subview: subValueLabel)
        subValueLabel.easy.layout(Bottom(3), Right(9))
        subValueLabel.font = UIFont.bold(.small)
        subValueLabel.textColor = AviobookColor.white.clouds
    }

    func configure(field: SelectableFieldState) {
        titleLabel.text = field.titleText
        valueLabel.text = field.stringValue
        subValueLabel.text = field.subValueText
        valueLabel.easy.reload()
    }

    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func buttonClicked() {
        didSelect?()
    }
}
