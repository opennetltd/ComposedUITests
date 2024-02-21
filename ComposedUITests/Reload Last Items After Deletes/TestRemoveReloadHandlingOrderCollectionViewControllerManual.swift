import Composed
import ComposedLayouts
import ComposedUI
import UIKit

final class TestRemoveReloadHandlingOrderCollectionViewControllerManual: UICollectionViewController, UICollectionViewDelegateFlowLayout {
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
            collectionView.reloadItems(at: [
                IndexPath(item: 1, section: 0),
                // Uses the "before" index path; using 2 for this will trigger a crash: "attempt to
                // delete and reload the same index path." However, this does not cause the cell to
                // be reloaded, seemingly because of a bug in `UICollectionView` introduced in iOS
                // 15.
                IndexPath(item: 3, section: 0),
            ])
        }
    }
}
