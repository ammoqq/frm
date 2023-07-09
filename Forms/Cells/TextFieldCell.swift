//
//  TextFieldCell.swift
//  AviobookUI
//
//  Created by Artur Osinski on 19/10/2018.
//

import EasyPeasy
import Foundation

import AviobookUtility

public class TextFieldCell: FormTableCell {
    let titleLabel = UILabel()
    var textField: TextField?
    let textFieldWidth: CGFloat?

    public override var isEnabled: Bool {
        didSet {
            textField?.isEnabled = isEnabled
            if !isEnabled {
                textField?.textColor = AviobookColor.white
            }
        }
    }

    public convenience override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        // Hardcoded number used before, ideally this initializer should not be used anymore
        self.init(style: style, reuseIdentifier: reuseIdentifier, textFieldWidth: 92)
    }

    public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, textFieldWidth: CGFloat? = nil) {
        self.textFieldWidth = textFieldWidth
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.add(subview: titleLabel)
        titleLabel.easy.layout(CenterY(), Left(AviobookStyle.Offset.medium))
        titleLabel.font = UIFont.bold(.small)
        titleLabel.textColor = AviobookColor.white.clouds
    }

    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(field: TextFieldState) {
        if textField == nil {
            switch field.keyboardType {
            case .numberPad:
                textField = NumericTextField(insets: nil)
            default:
                textField = TextField()
            }
            if let textFieldUnwrapped = textField {
                contentView.add(subview: textFieldUnwrapped)
                textFieldUnwrapped.easy.layout(
                    CenterY(-1),
                    Right(9),
                    Height(30))
                if let width = textFieldWidth {
                    textFieldUnwrapped.easy.layout(Width(width))
                } else {
                    textFieldUnwrapped.easy.layout(Left(AviobookStyle.Offset.small).to(titleLabel))
                }
                textFieldUnwrapped.maskCorners(radius: 2, cornerMask: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
                textFieldUnwrapped.font = UIFont.normal(.normal)
                textFieldUnwrapped.backgroundColor = AviobookColor.Primary.echo
                textFieldUnwrapped.textAlignment = .right
            }
        }

        titleLabel.text = field.titleText
        textField?.text = field.stringValue
        if field.inputState == InputState.imported.rawValue, isEnabled {
            textField?.textColor = AviobookColor.Alerts.imported
        } else {
            textField?.textColor = AviobookColor.white
        }
    }
}
