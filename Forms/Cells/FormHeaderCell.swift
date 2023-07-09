//
//  FormHeaderCell.swift
//  AviobookUI
//
//  Created by Artur Osinski on 17/08/2018.
//

import EasyPeasy
import Foundation

public class FormHeaderCell: UITableViewHeaderFooterView {
    let title = UILabel()
    let icon = UIImageView()

    static func reuseIdentifier() -> String {
        return "\(self)"
    }

    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }

    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        textLabel?.isHidden = true
        backgroundView = UIView()
        backgroundView?.backgroundColor = AviobookColor.Primary.charlie
        let container = UIView()
        container.addSubview(icon)
        container.addSubview(title)
        addSubview(container)
        container.easy.layout(Edges())
        icon.easy.layout(Size(AviobookUIConstant.Size.iconImageSize), Left(10), CenterY())
        title.easy.layout(Left(10).to(icon), CenterY(), Right())
        title.font = .semiBold(withSize: 20)
        title.textColor = AviobookColor.white
        icon.tintColor = AviobookColor.white
    }
}
