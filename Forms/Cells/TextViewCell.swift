//
//  TextViewCell.swift
//  AviobookUI
//
//  Created by Artur Osinski on 19/10/2018.
//

import EasyPeasy
import Foundation

import AviobookUtility

public class TextViewCell: FormTableCell, UITextViewDelegate {
    let titleLabel = UILabel()
    let textView = TextView()
    var textChanged: ((String) -> Void)?
    public override var isEnabled: Bool {
        didSet {
            textView.isEditable = isEnabled
        }
    }

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        height = 81
        contentView.add(subview: textView)
        contentView.add(subview: titleLabel)
        titleLabel.easy.layout(Top(8), Left(15))
        titleLabel.font = UIFont.bold(.small)
        titleLabel.textColor = AviobookColor.white.clouds

        textView.easy.layout(
            Top(),
            Left(),
            Right(),
            Bottom(-3))
        textView.textView.isScrollEnabled = false
        textView.textView.textContainerInset = UIEdgeInsets(top: 30, left: 10, bottom: 0, right: 0)
        textView.textView.font = UIFont.normal(.normal)
        textView.textView.textContainer.maximumNumberOfLines = 2
        textView.textView.delegate = self
        textView.backgroundColor = AviobookColor.Primary.echo
    }

    func configure(field: TextFieldState) {
        titleLabel.text = field.titleText
        textView.textView.text = field.stringValue
    }

    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "textInputBeginEditing"), object: nil, userInfo: ["textInput": textView])
        return true
    }

    public func textViewDidChange(_ textView: UITextView) {
        textChanged?(textView.text)
    }

    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "textInputEndEditing"), object: nil, userInfo: ["textInput": textView])
        return true
    }

    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let maxLengthOfText: CGFloat = 965
        let maxLengthOfLine: CGFloat = 485
        let existingLines = textView.text.components(separatedBy: CharacterSet.newlines)
        let newLines = text.components(separatedBy: CharacterSet.newlines)
        var hasTooManyChars = false
        var totalCount = 0
        let linesAfterChange = existingLines.count + newLines.count - 1

        guard let font = textView.font else {
            return linesAfterChange <= textView.textContainer.maximumNumberOfLines && !hasTooManyChars
        }

        for line in existingLines {
            let existingCount = totalCount
            totalCount += line.count
            guard !hasTooManyChars else { break }

            let editingCurrentLine = existingCount < range.location && range.location <= totalCount + 1
            let lineSize = line.size(withAttributes: [NSAttributedString.Key.font: font])

            if lineSize.width > maxLengthOfText, existingLines.count <= 1 {
                hasTooManyChars = true
            }
            if editingCurrentLine, existingLines.count > 1, lineSize.width > maxLengthOfLine {
                hasTooManyChars = true
            }
        }

        return linesAfterChange <= textView.textContainer.maximumNumberOfLines && !hasTooManyChars
    }
}
