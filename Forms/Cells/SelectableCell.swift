//
//  SelectableCell.swift
//  AviobookUI
//
//  Created by Artur Osinski on 21/09/2018.
//

import AviobookUtility
import EasyPeasy
import Foundation

public class SelectableCell: FormTableCell {
    let titleLabel = UILabel()
    let valueLabel = UILabel()
    let subValueLabel = UILabel()
    let bgEditView = UIView()
    let clickableButton = UIButton()
    public override var isEnabled: Bool {
        didSet {
            bgEditView.alpha = isEnabled ? 1 : 0.25
            isUserInteractionEnabled = isEnabled
        }
    }

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let editView = UIImageView()
        editView.translatesAutoresizingMaskIntoConstraints = false
        bgEditView.backgroundColor = AviobookColor.Secondary.delta
        contentView.add(subview: bgEditView)
        bgEditView.easy.layout(Top(), Right(), Bottom(), Width(40))
        bgEditView.add(subview: editView)
        editView.easy.layout(Edges(8))
        editView.image = ImageProvider.image(named: "edit").withRenderingMode(.alwaysTemplate)
        editView.tintColor = AviobookColor.white

        contentView.add(subview: titleLabel)
        titleLabel.easy.layout(CenterY(), Left(15), Width(150))
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
            Right(9).to(bgEditView),
            Left(10).to(titleLabel))

        valueLabel.font = UIFont.normal
        valueLabel.textColor = AviobookColor.white
        valueLabel.textAlignment = .right

        contentView.add(subview: subValueLabel)
        subValueLabel.easy.layout(Bottom(3), Right(9).to(bgEditView))
        subValueLabel.font = UIFont.bold(.small)
        subValueLabel.textColor = AviobookColor.white.clouds

        contentView.add(subview: clickableButton)
        clickableButton.easy.layout(Edges())
        clickableButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }

    func configure(field: SelectableFieldState) {
        titleLabel.text = field.titleText
        valueLabel.text = field.stringValue
        subValueLabel.text = field.subValueText
        let optionsExist = field.sections.flatMap { $0.options }.count > 1
        isUserInteractionEnabled = optionsExist && isEnabled
        bgEditView.alpha = optionsExist && isEnabled ? 1 : 0.25
        titleLabel.easy.layout(Width(titleLabel.intrinsicContentSize.width))
        valueLabel.easy.reload()
    }

    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func buttonClicked() {
        didSelect?()
    }
}
