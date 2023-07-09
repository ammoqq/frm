//
//  DualLabelFieldCell.swift
//  AviobookUI
//
//  Created by Artur Osinski on 26/11/2018.
//

import EasyPeasy
import Foundation

import AviobookUtility

open class DualLabelFieldCell: FormTableCell {
    public let titleLabel = UILabel()
    public let valueLabel = UILabel()
    public let secondaryValueLabel = UILabel()
    var titleIcon = UIView()
    var secondaryValueIcon = UIView()

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.add(subview: titleLabel)
        titleLabel.easy.layout(
            CenterY(),
            Left(15))
        titleLabel.font = UIFont.bold(.small)
        titleLabel.textColor = AviobookColor.white.clouds

        contentView.add(subview: secondaryValueLabel)
        secondaryValueLabel.easy.layout(
            CenterY(),
            Right(9),
            Left(120))
        secondaryValueLabel.font = UIFont.normal
        secondaryValueLabel.textColor = AviobookColor.white
        secondaryValueLabel.textAlignment = .right

        contentView.add(subview: valueLabel)
        valueLabel.easy.layout(
            CenterY(),
            Right(95),
            Width().like(secondaryValueLabel))
        valueLabel.font = UIFont.normal
        valueLabel.textColor = AviobookColor.white
        valueLabel.textAlignment = .right
    }

    public func configure(field: DualLabelIconFieldState) {
        titleLabel.text = field.titleText
        valueLabel.text = field.stringValue
        secondaryValueLabel.text = field.secondaryStringValue

        configureTitle(field: field)
        configureHighlight(field: field)
        configureLimit(field: field)
        configureTitleIcon(field: field)
        valueLabel.easy.reload()
    }

    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureTitle(field: DualLabelIconFieldState) {
        if field.isTitle {
            valueLabel.font = UIFont.smallBold
            valueLabel.textColor = AviobookColor.Secondary.delta
            secondaryValueLabel.font = UIFont.smallBold
            secondaryValueLabel.textColor = AviobookColor.Secondary.delta
        } else {
            valueLabel.font = UIFont.normal
            valueLabel.textColor = AviobookColor.white
            secondaryValueLabel.font = UIFont.normal
            secondaryValueLabel.textColor = AviobookColor.white
        }
    }

    func configureHighlight(field: DualLabelIconFieldState) {
        if field.isHighlighted {
            titleLabel.textColor = AviobookColor.white
            contentView.backgroundColor = AviobookColor.Secondary.delta
        } else {
            titleLabel.textColor = AviobookColor.white.clouds
            contentView.backgroundColor = AviobookColor.Primary.delta
        }
    }

    func configureLimit(field: DualLabelIconFieldState) {
        var secondaryLabel: UILabel?
        switch field.limit {
        case .structural:
            secondaryLabel = UILabel.circularIcon(withText: field.limit.displayValue)
        case .performance:
            secondaryLabel = UILabel.circularIcon(withText: field.limit.displayValue)
        case .none:
            break
        }

        if let secondaryLabelUNwrapped = secondaryLabel {
            secondaryValueIcon = secondaryLabelUNwrapped
            contentView.add(subview: secondaryValueIcon)
            secondaryValueIcon.easy.layout(
                Size(20),
                CenterY(),
                Left(13).to(valueLabel))
        } else {
            secondaryValueIcon.removeFromSuperview()
            secondaryValueIcon = UIView()
        }
    }

    func configureTitleIcon(field: DualLabelIconFieldState) {
        var localTitleIcon: UIView?
        if field.isClosestToMax {
            localTitleIcon = UILabel.circularIcon(withText: "L")
        }

        if let imageName = field.warningLevel.imageName {
            let image = ImageProvider.image(named: imageName)
            localTitleIcon = UIImageView(image: image)
        }

        if let localTitleIconUnwrapped = localTitleIcon {
            titleIcon.removeFromSuperview()
            titleIcon = localTitleIconUnwrapped
            contentView.add(subview: titleIcon)
            titleIcon.easy.layout(
                Size(25),
                Size(20).when { field.isClosestToMax },
                CenterY(),
                Left(13))
            titleLabel.easy.layout(Left(45))
        } else {
            titleIcon.removeFromSuperview()
            titleIcon = UIView()
            titleLabel.easy.layout(Left(15))
        }
    }
}
