import Composed
import ComposedLayouts
import ComposedUI
import UIKit

/// A counterpart to ``TestUpdateInsertUpdateRemoveUpdateCollectionViewController`` that performs
/// the same updates without using Composed.
final class TestUpdateInsertUpdateRemoveUpdateCollectionViewControllerManual: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private var values: [String] = []
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

        title = "Update → Insert → Update → Remove → Update"
        collectionView.backgroundColor = .systemBackground

        values = [
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
        ]
        collectionView.register(LabeledCollectionViewCell.self, forCellWithReuseIdentifier: "LabeledCollectionViewCell")

        if #available(iOS 14, *) {
            let menu = UIMenu(
                title: "Apply",
                children: [
                    UIAction(title: "All Updates", handler: { [unowned self] _ in
                        self.applyUpdate()
                    }),
                    UIAction(title: "All Updates (omit final update)", handler: { [unowned self] _ in
                        self.applyUpdateWithoutFinalUpdate()
                    }),
                    UIAction(title: "All Updates (omit final deletes and update)", handler: { [unowned self] _ in
                        self.applyUpdateWithoutFinalDeletesAndUpdate()
                    }),
                ]
            )
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply...", menu: menu)
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply", style: .plain, target: self, action: #selector(applyUpdate))
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        values.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LabeledCollectionViewCell", for: indexPath) as! LabeledCollectionViewCell
        let text = values[indexPath.item]
        var requestCount = valueRequestCounts[text, default: 0]
        requestCount += 1
        valueRequestCounts[text] = requestCount
        cell.label.text = "[\(requestCount)] " + values[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = collectionView.frame.size
        size.height = 32
        return size
    }

    @objc
    private func applyUpdate() {
        collectionView.performBatchUpdates {
            values = [
                "Item 0 (updated)",
                "Item 1 (updated)",
                "Item 2 (updated)",
                "Item 3 (updated)",
                "Item 4 (updated)",
                "Item 5 (updated)",

                "Item 6 (inserted)",
                "Item 7 (inserted)",
                "Item 8 (inserted)",
                "Item 9 (inserted)",

                "Item 6 → 10 (updated)",
                "Item 7 → 11 (updated)",
            ]

            collectionView.reloadItems(at: [
                IndexPath(item: 0, section: 0),
                IndexPath(item: 1, section: 0),
                IndexPath(item: 2, section: 0),
                IndexPath(item: 3, section: 0),
                IndexPath(item: 4, section: 0),
                IndexPath(item: 5, section: 0),
                IndexPath(item: 6, section: 0),
                IndexPath(item: 7, section: 0),
            ])
            collectionView.insertItems(at: [
                IndexPath(item: 6, section: 0),
                IndexPath(item: 7, section: 0),
                IndexPath(item: 8, section: 0),
                IndexPath(item: 9, section: 0),
            ])
            collectionView.deleteItems(at: [
                IndexPath(item: 8, section: 0),
                IndexPath(item: 9, section: 0),
                IndexPath(item: 10, section: 0),
                IndexPath(item: 11, section: 0),
            ])
            // TODO: Update 10
        }
    }

    private func applyUpdateWithoutFinalUpdate() {
        collectionView.performBatchUpdates {
            values = [
                "Item 0 (updated)",
                "Item 1 (updated)",
                "Item 2 (updated)",
                "Item 3 (updated)",
                "Item 4 (updated)",
                "Item 5 (updated)",

                "Item 6 (inserted)",
                "Item 7 (inserted)",
                "Item 8 (inserted)",
                "Item 9 (inserted)",

                "Item 6 (original)",
                "Item 7 → 11 (updated)",
            ]

            collectionView.reloadItems(at: [
                IndexPath(item: 0, section: 0),
                IndexPath(item: 1, section: 0),
                IndexPath(item: 2, section: 0),
                IndexPath(item: 3, section: 0),
                IndexPath(item: 4, section: 0),
                IndexPath(item: 5, section: 0),
                IndexPath(item: 7, section: 0),
            ])
            collectionView.insertItems(at: [
                IndexPath(item: 6, section: 0),
                IndexPath(item: 7, section: 0),
                IndexPath(item: 8, section: 0),
                IndexPath(item: 9, section: 0),
            ])
            collectionView.deleteItems(at: [
                IndexPath(item: 8, section: 0),
                IndexPath(item: 9, section: 0),
                IndexPath(item: 10, section: 0),
                IndexPath(item: 11, section: 0),
            ])
        }
    }

    private func applyUpdateWithoutFinalDeletesAndUpdate() {
        collectionView.performBatchUpdates {
            values = [
                "Item 0 (updated)",
                "Item 1 (updated)",
                "Item 2 (updated)",
                "Item 3 (updated)",
                "Item 4 (updated)",
                "Item 5 (updated)",

                "Item 6 (inserted)",
                "Item 7 (inserted)",
                "Item 8 (inserted)",
                "Item 9 (inserted)",

                "Item 6 (original)",
                "Item 7 → 11 (updated)",

                "Item 8 (original)",
                "Item 9 (original)",
            ]

            collectionView.reloadItems(at: [
                IndexPath(item: 0, section: 0),
                IndexPath(item: 1, section: 0),
                IndexPath(item: 2, section: 0),
                IndexPath(item: 3, section: 0),
                IndexPath(item: 4, section: 0),
                IndexPath(item: 5, section: 0),
                IndexPath(item: 7, section: 0),
            ])
            collectionView.insertItems(at: [
                IndexPath(item: 6, section: 0),
                IndexPath(item: 7, section: 0),
                IndexPath(item: 8, section: 0),
                IndexPath(item: 9, section: 0),
            ])
            collectionView.deleteItems(at: [
                IndexPath(item: 8, section: 0),
                IndexPath(item: 9, section: 0),
            ])
        }
    }
}
