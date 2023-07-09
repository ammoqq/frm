//
//  OutputIconCell.swift
//  AviobookUI
//
//  Created by Dries Steegmans on 16/10/2018.
//

import EasyPeasy
import Foundation

import AviobookUtility

public class OutputIconCell: OutputCell {
    private var icon = UIImageView()

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(icon)
        icon.easy.layout(Left(15), CenterY(), Size(25))
    }

    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setIconImage(_ image: UIImage? = nil) {
        icon.image = image
        if image != nil {
            icon.isHidden = false
            titleLabel.easy.layout(Left(10).to(icon))
        } else {
            icon.isHidden = true
            titleLabel.easy.layout(Left(15))
        }
    }

    public func configure(field: LabelIconFieldState) {
        titleLabel.text = field.titleText
        valueLabel.text = field.stringValue
        configureHighlight(field: field)
        if let iconName = field.warningLevel.imageName {
            setIconImage(ImageProvider.image(named: iconName))
        } else {
            setIconImage(field.icon)
        }

        if let color = field.stringValueColor {
            valueLabel.textColor = color
        }
    }

    func configureHighlight(field: LabelIconFieldState) {
        if field.isHighlighted {
            titleLabel.textColor = AviobookColor.white
            contentView.backgroundColor = AviobookColor.Secondary.delta
        } else {
            titleLabel.textColor = AviobookColor.white.clouds
            contentView.backgroundColor = AviobookColor.Primary.delta
        }
    }
}
