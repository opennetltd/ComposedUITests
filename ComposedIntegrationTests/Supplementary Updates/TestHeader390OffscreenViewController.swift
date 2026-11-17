import Composed
import ComposedUI
import UIKit

final class TestHeader390OffscreenViewController: UICollectionViewController {
    private let root = ComposedSectionProvider()
    private let market = ComposedSectionProvider()
    private let outcomes = SupplementaryRegressionSection(elements: ["Surviving item"], headerText: "Market header")
    private let precedingSections = (0..<390).map {
        SupplementaryRegressionSection(elements: ["Section \($0)"], headerText: "Header")
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
        title = "Header 390 → 63 Sections (Offscreen)"
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
            outcomes.headerText = "Updated market header"
            outcomes.performBatchUpdates { delegate in
                delegate?.sectionDidInvalidateHeader(outcomes)
            }
            root.remove(market)
            root.insert(market, at: 0)
            precedingSections.dropFirst(62).forEach { root.remove($0) }
        }
        collectionView.layoutIfNeeded()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
    }
}
