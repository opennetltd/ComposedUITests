import Composed
import ComposedLayouts
import ComposedUI
import UIKit

final class TestSelectionViewController: UICollectionViewController {
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

        title = "Composed Tests"
        collectionView.backgroundColor = .systemBackground

        let rootSection = ComposedTestsSection(elements: [
            ComposedTest(
                title: "[Composed] Item Removal → Surrounding Section Removals",
                viewControllerFactory: TestItemRemovalThenSurroundingSectionRemovalsViewController()
            ),
            ComposedTest(
                title: "[Composed] Insert → Refresh Footer",
                viewControllerFactory: TestInsertThenFooterViewController()
            ),
            ComposedTest(
                title: "[Composed] Insert → Refresh Footer → Cancel Insert",
                viewControllerFactory: TestInsertThenFooterThenRemoveInsertedViewController()
            ),
            ComposedTest(
                title: "[Composed] Resize Footer",
                viewControllerFactory: TestFooterResizeViewController()
            ),
            ComposedTest(
                title: "[Composed] Refresh Footer",
                viewControllerFactory: TestFooterOnlyViewController()
            ),
            ComposedTest(
                title: "[Composed] Refresh Footer → Remove Sections",
                viewControllerFactory: TestFooterThenRemoveViewController()
            ),
            ComposedTest(
                title: "[Composed] Refresh Footer → Move → Remove Sections",
                viewControllerFactory: TestFooterThenMoveAndRemoveViewController()
            ),
            ComposedTest(
                title: "[Composed] Insert → Refresh Footer → Move → Remove",
                viewControllerFactory: TestInsertThenFooterThenMoveAndRemoveViewController()
            ),
            ComposedTest(
                title: "[Composed] Footer 390 → 63 Sections (Visible)",
                viewControllerFactory: TestFooter390VisibleViewController()
            ),
            ComposedTest(
                title: "[Composed] Footer 390 → 63 Sections (Offscreen)",
                viewControllerFactory: TestFooter390OffscreenViewController()
            ),
            ComposedTest(
                title: "[Composed] Refresh Footer Outside Batch",
                viewControllerFactory: TestFooterOutsideBatchViewController()
            ),
            ComposedTest(
                title: "[Composed] Refresh Footer → Remove Containing Section",
                viewControllerFactory: TestFooterThenRemoveContainingSectionViewController()
            ),
            ComposedTest(
                title: "[Composed] Insert → Refresh Header",
                viewControllerFactory: TestInsertThenHeaderViewController()
            ),
            ComposedTest(
                title: "[Composed] Insert → Refresh Header → Cancel Insert",
                viewControllerFactory: TestInsertThenHeaderThenRemoveInsertedViewController()
            ),
            ComposedTest(
                title: "[Composed] Resize Header",
                viewControllerFactory: TestHeaderResizeViewController()
            ),
            ComposedTest(
                title: "[Composed] Refresh Header",
                viewControllerFactory: TestHeaderOnlyViewController()
            ),
            ComposedTest(
                title: "[Composed] Refresh Header → Remove Sections",
                viewControllerFactory: TestHeaderThenRemoveViewController()
            ),
            ComposedTest(
                title: "[Composed] Refresh Header → Move → Remove Sections",
                viewControllerFactory: TestHeaderThenMoveAndRemoveViewController()
            ),
            ComposedTest(
                title: "[Composed] Insert → Refresh Header → Move → Remove",
                viewControllerFactory: TestInsertThenHeaderThenMoveAndRemoveViewController()
            ),
            ComposedTest(
                title: "[Composed] Header 390 → 63 Sections (Visible)",
                viewControllerFactory: TestHeader390VisibleViewController()
            ),
            ComposedTest(
                title: "[Composed] Header 390 → 63 Sections (Offscreen)",
                viewControllerFactory: TestHeader390OffscreenViewController()
            ),
            ComposedTest(
                title: "[Composed] Refresh Header Outside Batch",
                viewControllerFactory: TestHeaderOutsideBatchViewController()
            ),
            ComposedTest(
                title: "[Composed] Refresh Header → Remove Containing Section",
                viewControllerFactory: TestHeaderThenRemoveContainingSectionViewController()
            ),
            ComposedTest(
                title: "[Compositional] Reload Header During Batch Updates",
                viewControllerFactory: TestReloadHeaderCompositionalLayoutDuringBatchUpdates()
            ),
            ComposedTest(
                title: "[Composed] Update → Insert → Update → Remove → Update",
                viewControllerFactory: TestUpdateInsertUpdateRemoveUpdateCollectionViewController()
            ),
            ComposedTest(
                title: "[Manual] Update → Insert → Update → Remove → Update",
                viewControllerFactory: TestUpdateInsertUpdateRemoveUpdateCollectionViewControllerManual()
            ),
            ComposedTest(
                title: "[Composed] Item Reloads → Section Removals",
                viewControllerFactory: TestItemUpdatesWithSectionRemovals()
            ),
            ComposedTest(
                title: "[Composed] Item Reloads → Section Inserts",
                viewControllerFactory: TestItemUpdatesWithSectionInserts()
            ),
            ComposedTest(
                title: "[Composed] Item Reloads → Section Removals and Inserts",
                viewControllerFactory: TestItemUpdatesWithSectionRemovalsAndInserts()
            ),
            ComposedTest(
                title: "[Composed] Remove, Remove Last, Reload Last",
                viewControllerFactory: TestRemove_RemoveLast_ReloadLast_ViewController()
            ),
            ComposedTest(
                title: "[Composed] Remove, Reload Last",
                viewControllerFactory: TestRemove_ReloadLast_ViewController()
            ),
            ComposedTest(
                title: "[Manual] Remove, Reload Last",
                viewControllerFactory: TestRemoveReloadHandlingOrderCollectionViewControllerManual()
            ),
            ComposedTest(
                title: "[Manual] Remove, Reconfigure Last",
                viewControllerFactory: TestRemoveReconfigureHandlingOrderCollectionViewControllerManual()
            ),
        ])
        rootSection.testSelectionHandler = { [unowned self] test in
            let viewController = test.viewControllerFactory()
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        collectionCoordinator = CollectionCoordinator(collectionView: collectionView, sections: rootSection)

        // "StartingTest" is passed as an argument so use UserDefaults to parse it.
        if let startingTestTitle = UserDefaults.standard.string(forKey: "StartingTest") {
            if let test = rootSection.elements.first(where: { $0.title == startingTestTitle }) {
                let viewController = test.viewControllerFactory()
                navigationController?.pushViewController(viewController, animated: false)
            }
        }
    }
}

private final class ComposedTestsSection: ArraySection<ComposedTest>, SingleUICollectionViewSection, CollectionFlowLayoutHandler, SelectionHandler {
    typealias TestSelectionHandler = (_ test: ComposedTest) -> Void

    var testSelectionHandler: TestSelectionHandler?

    func section(with traitCollection: UITraitCollection) -> ComposedUI.CollectionSection {
        let cell = CollectionCellElement(
            section: self,
            dequeueMethod: .fromClass(LabeledCollectionViewCell.self)
        ) { cell, index, section in
            cell.label.text = section.elements[index].title
        }
        return CollectionSection(section: self, cell: cell)
    }

    func sizeForItem(at index: Int, suggested: CGSize, metrics: CollectionFlowLayoutMetrics, environment: CollectionFlowLayoutEnvironment) -> CGSize {
        var size = environment.collectionView.frame.size
        size.height = 36
        return size
    }

    func shouldSelect(at index: Int) -> Bool {
        testSelectionHandler?(elements[index])
        return false
    }
}

private struct ComposedTest {
    typealias ViewControllerFactory = () -> UIViewController

    let title: String
    let viewControllerFactory: ViewControllerFactory

    internal init(title: String, viewControllerFactory: @autoclosure @escaping ComposedTest.ViewControllerFactory) {
        self.title = title
        self.viewControllerFactory = viewControllerFactory
    }
}

final class LabeledCollectionViewCell: UICollectionViewCell {
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSubviews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupSubviews()
    }

    private func setupSubviews() {
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
        ])
    }
}
