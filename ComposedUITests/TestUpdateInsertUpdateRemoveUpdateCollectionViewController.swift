import Composed
import ComposedLayouts
import ComposedUI
import UIKit

/// A test of a crash reported in Firebase. It performs multiple updates, then multiple insertions,
/// then multiple updates, then multiple removals, then an update.
final class TestUpdateInsertUpdateRemoveUpdateCollectionViewController: UICollectionViewController {
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

        title = "Update → Insert → Update → Remove → Update"
        collectionView.backgroundColor = .systemBackground

        rootSection = TestSection(elements: [
            "Item 0 (original)",
            "Item 1 (original)",
            "Item 2 (original)",
            "Item 3 (original)",
            "Item 4 (original)",
            "Item 5 (original)",
            "Item 6 (original)",
            "Item 7 (original)",
            "Item 8 (original)",
            "Item 9 (original)",
            "Item 10 (original)",
            "Item 11 (original)",
        ])
        collectionCoordinator = CollectionCoordinator(collectionView: collectionView, sections: rootSection)

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply", style: .plain, target: self, action: #selector(applyUpdate))
    }

    @objc
    private func applyUpdate() {
        rootSection.performBatchUpdates { _ in
            rootSection[1] = "Item 1 (updated)"
            rootSection[2] = "Item 2 (updated)"
            rootSection[3] = "Item 3 (updated)"
            rootSection[4] = "Item 4 (updated)"
            rootSection[5] = "Item 5 (updated)"
            rootSection.insert("Item 6 (inserted)", at: 6)
            rootSection.insert("Item 7 (inserted)", at: 7)
            rootSection.insert("Item 8 (inserted)", at: 8)
            rootSection.insert("Item 9 (inserted)", at: 9)
            rootSection[0] = "Item 0 (updated)"
            rootSection[11] = "Item 7 → 11 (updated)"
            rootSection.remove(at: 15)
            rootSection.remove(at: 14)
            // The below update will produce an invalid changeset, but it will only cause the wrong
            // cells to be refreshed.
//            rootSection.remove(at: 13)
            // The below update will produce an invalid changeset, which will cause the collection
            // view to trigger a crash.
//            rootSection.remove(at: 12)
            // We have never gotten this far...
//            rootSection[10] = "Item 10 (updated)"
        }
    }
}

final class TestSection: ArraySection<String>, SingleUICollectionViewSection, SelectionHandler, CollectionFlowLayoutHandler {
    private var valueRequestCounts: [String: Int] = [:]

    func section(with traitCollection: UITraitCollection) -> ComposedUI.CollectionSection {
        let cell = CollectionCellElement(
            section: self,
            dequeueMethod: .fromClass(LabeledCollectionViewCell.self)
        ) { cell, index, section in
            let text = section.elements[index]
            var requestCount = section.valueRequestCounts[text, default: 0]
            requestCount += 1
            section.valueRequestCounts[text] = requestCount
            cell.label.text = "[\(requestCount)] " + section.elements[index]
        }
        return CollectionSection(section: self, cell: cell)
    }

    func sizeForItem(at index: Int, suggested: CGSize, metrics: CollectionFlowLayoutMetrics, environment: CollectionFlowLayoutEnvironment) -> CGSize {
        var size = environment.collectionView.frame.size
        size.height = 32
        return size
    }
}
