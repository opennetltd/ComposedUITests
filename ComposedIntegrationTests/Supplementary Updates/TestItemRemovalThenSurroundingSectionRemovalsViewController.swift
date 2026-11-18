import Composed
import ComposedUI
import UIKit

final class TestItemRemovalThenSurroundingSectionRemovalsViewController: UICollectionViewController {
    private let root = ComposedSectionProvider()
    private let earlier = SupplementaryRegressionSection(elements: ["Earlier item"])
    private let surviving = SupplementaryRegressionSection(elements: ["Surviving item"])
    private let later = SupplementaryRegressionSection(elements: ["Later item"])
    private var coordinator: CollectionCoordinator?

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 280, height: 30)
        super.init(collectionViewLayout: layout)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Item Removal → Surrounding Section Removals"
        collectionView.backgroundColor = .systemBackground
        root.append(earlier)
        root.append(surviving)
        root.append(later)
        coordinator = CollectionCoordinator(collectionView: collectionView, sectionProvider: root)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply", style: .plain, target: self, action: #selector(applyUpdates))
    }

    @objc
    private func applyUpdates() {
        navigationItem.rightBarButtonItem?.isEnabled = false
        root.performBatchUpdates { _ in
            surviving.remove(at: 0)
            root.remove(earlier)
            root.remove(later)
        }
    }
}
