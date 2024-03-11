import Composed
import ComposedLayouts
import ComposedUI
import UIKit

final class TestRemoveReconfigureHandlingOrderCollectionViewControllerManual: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private var values: [[String]] = []
    private var valueRequestCounts: [String: Int] = [:]

    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Remove Reload Handling"
        collectionView.backgroundColor = .systemBackground
        collectionView.alwaysBounceVertical = true

        values = [
            [
                "Item 0, 0 (original)",
                "Item 0, 1 (original)",
                "Item 0, 2 (original)",
                "Item 0, 3 (original)",
            ],
        ]
        collectionView.register(LabeledCollectionViewCell.self, forCellWithReuseIdentifier: "LabeledCollectionViewCell")

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply", style: .plain, target: self, action: #selector(applyUpdate))
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        values.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        values[section].count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LabeledCollectionViewCell", for: indexPath) as! LabeledCollectionViewCell
        let text = values[indexPath.section][indexPath.item]
        var requestCount = valueRequestCounts[text, default: 0]
        requestCount += 1
        valueRequestCounts[text] = requestCount
        cell.label.text = "[\(requestCount)] " + text
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = collectionView.frame.size
        size.height = 36
        return size
    }

    @objc
    private func applyUpdate() {
        collectionView.performBatchUpdates {
            values = [
                [
                    "Item 0, 0 (original)",
                    "Item 0, 1 (updated)",
                    "Item 0, 3 → 0, 2 (updated)",
                ],
            ]
            collectionView.deleteItems(at: [
                IndexPath(item: 2, section: 0),
            ])
            if #available(iOS 15.0, *) {
                collectionView.reconfigureItems(at: [
                    IndexPath(item: 1, section: 0),
                    // Uses the "after" index path (unlike a reload). The cell can be seen both
                    // updated and removed at the same time.
                    // Using 3 for this will trigger a crash, but not internally, instead it will
                    // crash in `collectionView(_:cellForItemAt:)` because the collection view
                    // requests a cell at index 3, which does not exist at this point.
                    // It seems that `reconfigureItems(at:)` is not intended to be used within a
                    // `performBatchUpdates` call.
                    IndexPath(item: 2, section: 0),
                ])
            } else {
                assertionFailure("This test requires iOS 15")
            }
        }
    }
}
