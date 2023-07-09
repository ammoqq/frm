//
//  NestedSelectableCell.swift
//  WeightAndBalanceComponent
//
//  Created by Artur Osinski on 20/09/2018.
//

import EasyPeasy
import Foundation

import AviobookUtility

open class NestedSelectableCell: UICollectionViewCell, BundleImageLoader {
    open var title = UILabel()
    open var subtitle = UILabel()
    open var iconView = UIImageView()
    open var checkmarkView = CheckmarkView(iconSize: 12, radius: 12)

    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = AviobookColor.Primary.delta
        layer.cornerRadius = AviobookStyle.cornerRadius
        addSubviews([title, subtitle, checkmarkView])
        title.easy.layout(
            CenterY().when { [weak self] in self?.subtitle.text == nil },
            CenterY(-8).when { [weak self] in self?.subtitle.text != nil },
            Left(16),
            Right(40))
        subtitle.easy.layout(
            Top(2).to(title),
            Left(16),
            Right(40))

        title.font = .normal
        title.textColor = AviobookColor.Text.active
        title.numberOfLines = 2
        subtitle.textColor = AviobookColor.Text.inactive
        subtitle.font = .small

        checkmarkView.easy.layout(
            CenterY(),
            Right(14),
            Size(24))

        addShadow(radius: 1, opacity: 1, shadowOffset: CGSize(width: 2, height: 2), color: AviobookColor.darkShadow.withAlphaComponent(0.25))
    }

    public func configure(data: SelectableOption, context: [String: Any]) {
        checkmarkView.isHidden = !data.isSelected
        title.text = data.option.mainValue(context: context)
        subtitle.text = data.option.subValue(context: context)
        if data.isSelected {
            backgroundColor = AviobookColor.Primary.echo
        } else {
            backgroundColor = AviobookColor.Primary.delta
        }
        title.easy.reload()
    }

    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
