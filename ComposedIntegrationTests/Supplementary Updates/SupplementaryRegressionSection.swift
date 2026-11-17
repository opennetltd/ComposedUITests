import Composed
import ComposedLayouts
import ComposedUI
import UIKit

final class SupplementaryRegressionSection: ArraySection<String>, SingleUICollectionViewSection, CollectionFlowLayoutHandler {
    let accessibilityID = UUID().uuidString
    var headerText: String?
    var footerText: String?
    var supplementaryHeight: CGFloat = 25

    init(elements: [String], headerText: String? = nil, footerText: String? = nil) {
        self.headerText = headerText
        self.footerText = footerText
        super.init(elements: elements)
    }

    func section(with traitCollection: UITraitCollection) -> CollectionSection {
        let cell = CollectionCellElement(
            section: self,
            dequeueMethod: .fromClass(LabeledCollectionViewCell.self)
        ) { cell, index, section in
            cell.accessibilityIdentifier = "\(section.accessibilityID)-\(index)"
            cell.label.text = section.elements[index]
        }
        let header = headerText.map { _ in
            CollectionSupplementaryElement(
                section: self,
                dequeueMethod: .fromClass(RegressionSupplementaryView.self),
                kind: .custom(kind: UICollectionView.elementKindSectionHeader)
            ) { view, _, section in
                view.label.text = section.headerText
                view.label.accessibilityIdentifier = "regression-header-\(section.accessibilityID)"
            }
        }
        let footer = footerText.map { _ in
            CollectionSupplementaryElement(
                section: self,
                dequeueMethod: .fromClass(RegressionSupplementaryView.self),
                kind: .custom(kind: UICollectionView.elementKindSectionFooter)
            ) { view, _, section in
                view.label.text = section.footerText
                view.label.accessibilityIdentifier = "regression-footer-\(section.accessibilityID)"
            }
        }
        return CollectionSection(section: self, cell: cell, header: header, footer: footer)
    }

    func referenceHeaderSize(suggested: CGSize, environment: CollectionFlowLayoutEnvironment) -> CGSize {
        CGSize(width: environment.contentSize.width, height: headerText == nil ? 0 : supplementaryHeight)
    }

    func referenceFooterSize(suggested: CGSize, environment: CollectionFlowLayoutEnvironment) -> CGSize {
        CGSize(width: environment.contentSize.width, height: footerText == nil ? 0 : supplementaryHeight)
    }
}
