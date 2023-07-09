//
//  SelectableCollectionHeader.swift
//  WeightAndBalanceComponent
//
//  Created by Artur Osinski on 20/09/2018.
//

import EasyPeasy
import Foundation

class SelectableCollectionHeader: UICollectionReusableView {
    let header: UILabel = {
        let header = UILabel()
        header.textColor = AviobookColor.Secondary.delta
        header.font = UIFont.bold(.title)
        header.lineBreakMode = .byWordWrapping
        header.numberOfLines = 0
        return header
    }()

    func setTitleText(_ title: String) {
        addSubview(header)
        header.easy.layout(
            Left(),
            CenterY())
        header.text = title.uppercased()
    }
}
