//
//  TableSection.swift
//  AviobookUtility
//
//  Created by Artur Osinski on 08/08/2018.
//

import Foundation

public class TableSection {
    public private(set) var cells: [FormTableCell]
    var headerTitle: String?
    var footerTitle: String?
    var header: FormHeaderCell?
    var roundedCorners: Bool

    public init(cells: [FormTableCell], header: FormHeaderCell?, headerTitle _: String? = nil, footerTitle: String? = nil, roundedCorners: Bool) {
        self.cells = cells
        self.footerTitle = footerTitle
        self.header = header
        self.roundedCorners = roundedCorners
    }

    public func removeCellAt(_ index: Int) {
        cells.remove(at: index)
    }

    public func addCell(_ cell: FormTableCell, at index: Int) {
        cells.insert(cell, at: index)
    }
}
