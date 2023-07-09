//
//  SelectableOptionsViewController.swift
//  WeightAndBalanceComponent
//
//  Created by Artur Osinski on 20/09/2018.
//

import AviobookUtility
import EasyPeasy
import Foundation

public class SelectableOptionsViewController: CloseDialogViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()

    public var sections: [SelectableOptionsSection] = []
    public var context: [String: Any] = [:]
    public let collectionContainerView = UIView()
    public let topLabel = UILabel()
    public let tappableView = UIView()
    public var selectedIndexPath: IndexPath?
    public var selectedOption: (([SelectableOptionsSection]) -> Void)?

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.isOpaque = false
        view.add(subview: tappableView)
        tappableView.easy.layout(Edges())
        tappableView.backgroundColor = AviobookColor.clear
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(closeModal))
        tappableView.addGestureRecognizer(tapGesture)
        view.add(subview: collectionContainerView)

        collectionContainerView.backgroundColor = AviobookColor.Primary.charlie
        collectionView.backgroundColor = AviobookColor.Primary.charlie
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(NestedSelectableCell.self, forCellWithReuseIdentifier: NestedSelectableCell.reuseIdentifier)
        collectionView.register(SelectableCollectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SelectableCollectionHeader.reuseIdentifier)
        collectionContainerView.setRoundedCorners(radius: 8)
        collectionContainerView.easy.layout(
            CenterY().with(.low),
            Height(695).with(.low),
            Right(37),
            Left(37),
            Top(>=100).with(.high),
            Bottom(<=60).with(.high))
        collectionContainerView.add(subview: collectionView)
        collectionView.easy.layout(Top(97), Right(15), Left(15), Bottom(15))

        collectionContainerView.add(subview: topLabel)
        topLabel.easy.layout(CenterX(), Top(30), Height(37))
        topLabel.font = .normal(withSize: 22)
        topLabel.textColor = AviobookColor.white

        let cancelButton = UIButton()
        cancelButton.setImage(ImageProvider.image(named: "cancel").withRenderingMode(.alwaysTemplate), for: .normal)
        cancelButton.imageView?.tintColor = AviobookColor.white
        cancelButton.contentEdgeInsets = UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)

        cancelButton.addTarget(self, action: #selector(closeModal), for: .touchDown)
        collectionContainerView.add(subview: cancelButton)
        cancelButton.easy.layout(
            Size(50),
            Right(),
            Top())
    }

    public func collectionView(_: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].options.count
    }

    public func numberOfSections(in _: UICollectionView) -> Int {
        return sections.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NestedSelectableCell.reuseIdentifier, for: indexPath) as? NestedSelectableCell else { return UICollectionViewCell() }
        let optionData = sections[indexPath.section].options[indexPath.row]
        if optionData.isSelected {
            selectedIndexPath = indexPath
        }
        cell.configure(data: optionData, context: context)
        return cell
    }

    public func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectItemAt(indexPath: indexPath)
    }

    public func collectionView(_: UICollectionView,
                               layout _: UICollectionViewLayout,
                               sizeForItemAt _: IndexPath) -> CGSize {
        return CGSize(width: 215, height: 65)
    }

    public func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumInteritemSpacingForSectionAt _: Int) -> CGFloat {
        return 1
    }

    public func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if sections[section].title.isNotEmpty {
            return CGSize(width: 293, height: 37)
        } else {
            return .zero
        }
    }

    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader,
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                         withReuseIdentifier: SelectableCollectionHeader.reuseIdentifier,
                                                                         for: indexPath) as? SelectableCollectionHeader {
            header.setTitleText(sections[indexPath.section].title)
            return header
        } else {
            return UICollectionReusableView()
        }
    }

    func selectItemAt(indexPath: IndexPath) {
        guard selectedIndexPath != indexPath else { return }
        var newSections: [SelectableOptionsSection] = []
        for section in sections {
            let optionsMapped = section.options.map { SelectableOption(isSelected: false, option: $0.option) }
            let newSection = SelectableOptionsSection(title: section.title, options: optionsMapped)
            newSections.append(newSection)
        }
        newSections[indexPath.section].options[indexPath.row].changeSelection(isSelected: true)
        sections = newSections
        collectionView.reloadData()
        dismiss(animated: true, completion: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.selectedOption?(strongSelf.sections)
        })
    }

    @objc func closeModal() {
        dismiss(animated: true, completion: nil)
    }
}
