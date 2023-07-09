//
//  FormCell.swift
//  AviobookUtility
//
//  Created by Artur Osinski on 08/08/2018.
//

import AviobookUtility
import EasyPeasy
import Foundation
import UIKit

public typealias Rendered<A, Element> = (RenderingContext<A>) -> RenderedElement<Element, A>
public typealias RenderedTableSection<A> = Rendered<A, TableSection>
public typealias TableForm<A> = Rendered<A, [TableSection]>

open class FormTableCell: UITableViewCell {
    open var height: CGFloat = 41
    open var isEnabled = true
    var shouldHighlight = false
    var didSelect: (() -> Void)?

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = AviobookColor.clear
        contentView.backgroundColor = AviobookColor.Primary.delta
        contentView.easy.layout(Top(), Left(), Right(), Bottom(1))
    }

    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class FormTableViewController: UITableViewController {
    let headerSpacing: CGFloat = 50
    let cellSpacing: CGFloat = 5
    public private(set) var sections: [TableSection] = []
    var firstResponder: UIResponder?

    public init(sections: [TableSection], title: String, firstResponder: UIResponder? = nil) {
        self.firstResponder = firstResponder
        self.sections = sections
        super.init(style: .grouped)
        navigationItem.title = title
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.sectionFooterHeight = 0
    }

    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewWillAppear(_: Bool) {
        // Not calling super here on purpose - it disables autoscrolling of the view
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        firstResponder?.becomeFirstResponder()
        tableView.tableFooterView = UIView()
    }

    public override func numberOfSections(in _: UITableView) -> Int {
        return sections.count
    }

    public func disableForm() {
        sections.forEach {
            $0.cells.forEach {
                $0.isEnabled = false
            }
        }
    }

    public override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].cells.count
    }

    func cell(for indexPath: IndexPath) -> FormTableCell {
        let cell = sections[indexPath.section].cells[indexPath.row]
        let shouldRound = sections[indexPath.section].roundedCorners

        if indexPath.row == 0, shouldRound {
            cell.maskCorners(radius: 5, cornerMask: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        }

        if indexPath.row == sections[indexPath.section].cells.count - 1, shouldRound {
            cell.maskCorners(radius: 5, cornerMask: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        }
        if sections[indexPath.section].cells.count == 1, shouldRound {
            cell.maskCorners(radius: 5, cornerMask: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        }

        return cell
    }

    public override func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cell(for: indexPath)
    }

    public override func tableView(_: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return cell(for: indexPath).shouldHighlight
    }

    public override func tableView(_: UITableView, titleForFooterInSection section: Int) -> String? {
        return sections[section].footerTitle
    }

    public override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        cell(for: indexPath).didSelect?()
    }

    public override func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = sections[section].header else {
            return nil
        }
        view.title.text = sections[section].headerTitle
        return view
    }

    public override func tableView(_: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].header != nil ? headerSpacing : cellSpacing
    }

    public override func tableView(_: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].header != nil ? headerSpacing : cellSpacing
    }

    public override func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cell(for: indexPath).height
    }

    public func estimatedTableHeight() -> CGFloat {
        let initialHeight: CGFloat = (tableView.tableHeaderView?.frame.size.height ?? 0) + (tableView.tableFooterView?.frame.size.height ?? 0)
        return sections.reduce(initialHeight) { (height, section) -> CGFloat in
            let sectionHeight = height + (section.header != nil ? headerSpacing : cellSpacing)
            return section.cells.map { $0.height }.reduce(sectionHeight, +)
        }
    }
}

extension UIView {
    public func maskCorners(radius: CGFloat, cornerMask: CACornerMask) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = cornerMask
    }
}
