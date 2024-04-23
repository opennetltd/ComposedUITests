import Composed
import ComposedLayouts
import ComposedUI
import UIKit

final class TestRemove_ReloadLast_ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private var rootSection: TestSection!
    private var collectionCoordinator: CollectionCoordinator!

    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Remove, Reload Last"
        collectionView.backgroundColor = .systemBackground
        collectionView.alwaysBounceVertical = true

        rootSection = TestSection(elements: [
            "Item 0, 0 (original)",
            "Item 0, 1 (original)",
            "Item 0, 2 (original)",
            "Item 0, 3 (original)",
            "Item 0, 4 (original)",
        ])
        collectionCoordinator = CollectionCoordinator(collectionView: collectionView, sections: rootSection)
        collectionCoordinator.enableLogs = true
        collectionCoordinator.logger = { message in
            print("[TestRemoveReloadHandlingOrderCollectionViewController]", message)
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply", style: .plain, target: self, action: #selector(applyUpdate))
    }

    @objc
    private func applyUpdate() {
        rootSection.performBatchUpdates { _ in
            rootSection.remove(at: 1)
            rootSection.remove(at: 1)
            rootSection[1] = "Item 0, 3 → 0, 1 (updated)"
            rootSection[2] = "Item 0, 4 → 0, 2 (updated)"
        }
    }
}
