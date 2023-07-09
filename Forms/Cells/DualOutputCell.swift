//
//  DualOutputCell.swift
//  PhaseOfFlightComponent
//
//  Created by Jeroen Abrahams on 12/02/2020.
//

import EasyPeasy
import Foundation

public class DualOutputCell: FormTableCell {
    private let leftOutputCell: OutputCell
    private let rightOutputCell: OutputCell
    private let stackView = UIStackView()
    private static let spacingBetweenCells: CGFloat = 1

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        leftOutputCell = OutputCell(style: style, reuseIdentifier: nil)
        rightOutputCell = OutputCell(style: style, reuseIdentifier: nil)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = AviobookColor.clear
        setup()
    }

    func update(data: DualLabelFieldState) {
        leftOutputCell.titleLabel.text = data.titleText
        leftOutputCell.valueLabel.text = data.stringValue
        rightOutputCell.titleLabel.text = data.secondTitleText
        rightOutputCell.valueLabel.text = data.secondStringValue
    }

    private func setup() {
        contentView.addSubview(stackView)
        stackView.easy.layout(Edges())
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = Self.spacingBetweenCells
        stackView.addArrangedSubviews([leftOutputCell.contentView, rightOutputCell.contentView])
    }

    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
