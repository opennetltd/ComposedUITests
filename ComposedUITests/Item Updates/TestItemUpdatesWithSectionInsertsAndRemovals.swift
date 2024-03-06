import Composed
import ComposedLayouts
import ComposedUI
import UIKit

final class TestComposedSectionProvider: ComposedSectionProvider {
    init(elements: [[String]]) {
        super.init()

        for sectionContents in elements {
            let section = TestSection(elements: sectionContents)
            append(testSection: section)
        }
    }

    func append(testSection: TestSection) {
        append(testSection)
    }

    subscript(_ index: Int) -> TestSection! {
        sections[index] as? TestSection
    }
}

/// The intergration test for `ChangesReduerTests.testUpdateElementsRemoveSection`.
final class TestItemUpdatesWithSectionInsertsAndRemovals: UICollectionViewController {
    private typealias Step = () -> Void

    private var rootSection: TestComposedSectionProvider!
    private var collectionCoordinator: CollectionCoordinator!
    private var steps: [Step] = []

    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Item Reloads → Section Inserts/Removals"
        collectionView.backgroundColor = .systemBackground

        rootSection = TestComposedSectionProvider(elements: [
            [
                "Item 0, 0 (original)",
                "Item 0, 1 (original)",
            ],
            [
                "Item 1, 0 (original)",
                "Item 1, 1 (original)",
            ],
            [
                "Item 2, 0 (original)",
                "Item 2, 1 (original)",
            ],
            [
                "Item 3, 0 (original)",
                "Item 3, 1 (original)",
            ],
            [
                "Item 4, 0 (original)",
                "Item 4, 1 (original)",
            ],
        ])
        collectionCoordinator = CollectionCoordinator(collectionView: collectionView, sectionProvider: rootSection)

        steps = [
            { [unowned self] in
                rootSection[2][1] = "Item 2, 1 (updated)"
            },
            { [unowned self] in
                rootSection[4][0] = "Item 4, 0 (updated)"
            },
            { [unowned self] in
                rootSection.remove(at: 1)
            },
            { [unowned self] in
                rootSection.remove(at: 2)
            },
            { [unowned self] in
                rootSection.remove(at: 1)
            },
        ]

        if #available(iOS 14, *) {
            let menuAction = Array((1 ... steps.count).reversed()).enumerated().map { (index, stepCount) in
                let isFirst = index == 0

                if isFirst {
                    return UIAction(title: "Apply All Updates", handler: { [unowned self] _ in
                        self.applyAllUpdates()
                    })
                } else {
                    return UIAction(title: "Apply First (\(stepCount)) update(s)", handler: { [unowned self] _ in
                        self.applyFirstUpdates(updateCount: stepCount)
                    })
                }
            }
            let menu = UIMenu(
                title: "Apply",
                children: menuAction
            )
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply...", menu: menu)
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply", style: .plain, target: self, action: #selector(applyAllUpdates))
        }
    }

    private func applyFirstUpdates(updateCount: Int) {
        rootSection.performBatchUpdates { _ in
            for update in steps.prefix(updateCount) {
                update()
            }
        }
    }

    @objc
    private func applyAllUpdates() {
        applyFirstUpdates(updateCount: steps.count)
    }
}
