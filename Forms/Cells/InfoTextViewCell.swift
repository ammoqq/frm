//
//  InfoTextViewCell.swift
//  AviobookUI
//
//  Created by Paweł Wiergowski on 26/11/2019.
//

import EasyPeasy
import Foundation

import AviobookUtility

public class InfoTextViewCell: FormTableCell {
    let titleLabel = UILabel()
    let textView = MonospacedTextLabel()

    public override var height: CGFloat {
        get {
            return 60 + textView.label.frame.size.height
        }
        set {}
    }

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(titleLabel)
        titleLabel.easy.layout(Top(10), Left(10), Right(10))
        titleLabel.textColor = AviobookColor.white
        titleLabel.font = .bold(.title)

        contentView.addSubview(textView)
        textView.easy.layout(Left(10), Right(10), Top(10).to(titleLabel, .bottom))
    }

    func configure(field: TextFieldState) {
        titleLabel.text = field.titleText
        textView.text = field.stringValue
        textView.label.sizeToFit()
    }

    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
