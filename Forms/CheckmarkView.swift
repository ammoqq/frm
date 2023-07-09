//
//  CheckmarkView.swift
//  AviobookUI
//
//  Created by Dries Steegmans on 28/02/2019.
//

import EasyPeasy
import Foundation

public class CheckmarkView: UIView {
    private let iconView = UIImageView()

    public override var isHidden: Bool {
        didSet {
            if !isHidden {
                backgroundColor = AviobookColor.Secondary.delta
            }
        }
    }

    public init(iconSize: CGFloat, radius: CGFloat) {
        super.init(frame: .zero)
        backgroundColor = AviobookColor.Secondary.delta
        setRoundedCorners(radius: radius)

        iconView.image = ImageProvider.image(named: "checkmark").maskWithColor(.white)
        addSubview(iconView)
        iconView.easy.layout(
            Center(),
            Size(iconSize))
    }

    required init?(coder _: NSCoder) {
        return nil
    }
}
