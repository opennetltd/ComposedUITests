import Composed
import ComposedUI
import UIKit

final class TestFooterOutsideBatchViewController: UICollectionViewController {
    private let root = ComposedSectionProvider()
    private let market = ComposedSectionProvider()
    private let outcomes = SupplementaryRegressionSection(elements: ["Surviving item"], footerText: "Market footer")
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
        title = "Refresh Footer Outside Batch"
        collectionView.backgroundColor = .systemBackground
        market.append(outcomes)
        root.append(market)
        coordinator = CollectionCoordinator(collectionView: collectionView, sectionProvider: root)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply", style: .plain, target: self, action: #selector(applyUpdates))
    }

    @objc
    private func applyUpdates() {
        navigationItem.rightBarButtonItem?.isEnabled = false
        outcomes.footerText = "Updated market footer"
        outcomes.updateDelegate?.sectionDidInvalidateFooter(outcomes)
        collectionView.layoutIfNeeded()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
    }
}
