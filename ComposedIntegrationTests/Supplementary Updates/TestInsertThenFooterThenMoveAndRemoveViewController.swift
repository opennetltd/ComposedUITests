import Composed
import ComposedUI
import UIKit

final class TestInsertThenFooterThenMoveAndRemoveViewController: UICollectionViewController {
    private let root = ComposedSectionProvider()
    private let market = ComposedSectionProvider()
    private let outcomes = SupplementaryRegressionSection(elements: ["Surviving item"], footerText: "Market footer")
    private let precedingSections = (0..<8).map {
        SupplementaryRegressionSection(elements: ["Section \($0)"], footerText: "Footer")
    }
    private var coordinator: CollectionCoordinator?

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 280, height: 30)
        layout.minimumLineSpacing = 0
        super.init(collectionViewLayout: layout)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Insert → Refresh Footer → Move → Remove"
        collectionView.backgroundColor = .systemBackground
        precedingSections.forEach { root.append($0) }
        market.append(outcomes)
        root.append(market)
        coordinator = CollectionCoordinator(collectionView: collectionView, sectionProvider: root)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply", style: .plain, target: self, action: #selector(applyUpdates))
    }

    @objc
    private func applyUpdates() {
        navigationItem.rightBarButtonItem?.isEnabled = false
        root.performBatchUpdates { _ in
            let inserted = (0..<8).map { _ in
                SupplementaryRegressionSection(elements: ["Inserted"], footerText: "Footer")
            }
            inserted.forEach { root.insert($0, at: 0) }
            outcomes.footerText = "Updated market footer"
            outcomes.performBatchUpdates { delegate in
                delegate?.sectionDidInvalidateFooter(outcomes)
            }
            root.remove(market)
            root.insert(market, at: 0)
            precedingSections.forEach { root.remove($0) }
            inserted.forEach { root.remove($0) }
        }
        collectionView.layoutIfNeeded()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
    }
}
