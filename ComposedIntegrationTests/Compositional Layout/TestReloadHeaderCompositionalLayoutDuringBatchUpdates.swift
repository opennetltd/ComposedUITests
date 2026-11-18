import Composed
import ComposedLayouts
import ComposedUI
import UIKit

final class TestReloadHeaderCompositionalLayoutDuringBatchUpdates: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private var headers: [Int: (height: CGFloat, text: String)] = [:]
    private var values: [[String]] = []
    private var haveRemovedSection = false

    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Reload Header During Batch Updates"
        collectionView.backgroundColor = .systemBackground
        collectionView.alwaysBounceVertical = true

        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { [unowned self] sectionIndex, _ in
            let section = NSCollectionLayoutSection(
                group: NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(CGFloat(36 * values[sectionIndex].count))
                    ),
                    subitems: [
                        NSCollectionLayoutItem(
                            layoutSize: NSCollectionLayoutSize(
                                widthDimension: .fractionalWidth(1),
                                heightDimension: .absolute(36)
                            ),
                            supplementaryItems: []
                        )
                    ]
                )
            )

            if let header = headers[sectionIndex] {
                section.boundarySupplementaryItems = [
                    NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: NSCollectionLayoutSize(
                            widthDimension: .fractionalWidth(1),
                            heightDimension: .absolute(header.height)
                        ),
                        elementKind: UICollectionView.elementKindSectionHeader,
                        alignment: .top
                    )
                ]
            }

            return section
        })

        values = [
            [
                "Item 0, 0 (original)",
                "Item 0, 1 (original)",
                "Item 0, 2 (original)",
                "Item 0, 3 (original)",
                "Item 0, 4 (original)",
                "Item 0, 5 (original)",
                "Item 0, 6 (original)",
                "Item 0, 7 (original)",
                "Item 0, 8 (original)",
            ],
            [
                "Item 1, 0 (original)",
                "Item 1, 1 (original)",
                "Item 1, 2 (original)",
                "Item 1, 3 (original)",
            ],
            [
                "Item 2, 0 (original)",
                "Item 2, 1 (original)",
                "Item 2, 2 (original)",
                "Item 2, 3 (original)",
            ],
            [
                "Item 3, 0 (original)",
                "Item 3, 1 (original)",
                "Item 3, 2 (original)",
                "Item 3, 3 (original)",
            ],
            [
                "Item 4, 0 (original)",
                "Item 4, 1 (original)",
                "Item 4, 2 (original)",
                "Item 4, 3 (original)",
            ],
        ]
        headers = [
            0: (50, "Section 0"),
            1: (50, "Section 1"),
            2: (50, "Section 2"),
            3: (50, "Section 3"),
        ]
        collectionView.register(LabeledCollectionViewCell.self, forCellWithReuseIdentifier: "LabeledCollectionViewCell")
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Tests...",
            menu: UIMenu(children: [
                UIAction(title: "✅ Reconfigure Header in Separate Batch", handler: { [unowned self] _ in
                    self.applyUpdate_reconfigureInSeparateBatch()
                }),
                UIAction(title: "⚠️ Invalidate Header in Separate Batch", handler: { [unowned self] _ in
                    self.applyUpdate_invalidateInSeparateBatch()
                }),
                UIAction(title: "💥 Invalidate Header Using Before Index", handler: { [unowned self] _ in
                    self.applyUpdate_invalidateHeaderAtBeforeIndex()
                }),
                UIAction(title: "💥 Invalidate Header Using After Index", handler: { [unowned self] _ in
                    self.applyUpdate_invalidateHeaderAtAfterIndex()
                }),
                UIAction(title: "⚠️ Reconfigure Header Using Before Index", handler: { [unowned self] _ in
                    self.applyUpdate_configureHeaderWithIndexBeforeUpdates()
                }),
                UIAction(title: "⚠️ Reconfigure Header Using After Index", handler: { [unowned self] _ in
                    self.applyUpdate_configureHeaderWithIndexAfterUpdates()
                }),
            ])
        )
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
        cell.label.text = text
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
        view.label.text = headers[indexPath.section]?.text
        view.backgroundColor = .green
        return view
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = collectionView.frame.size
        size.height = 36
        return size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if let height = headers[section]?.height {
            return CGSize(width: collectionView.bounds.width, height: height)
        }

        return .zero
    }

    private func reconfigureHeaderForSection(_ section: Int) {
        guard let view = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: section)) as? HeaderView else { return }
        view.label.text = headers[section]?.text
    }

    private func applyUpdate_reconfigureInSeparateBatch() {
        collectionView.performBatchUpdates {
            headers = [
                0: (30, "Section 1 -> 0 (updated)"),
            ]

            values = [values[1]]
            collectionView.deleteSections([0, 2, 3, 4])
        }
        collectionView.performBatchUpdates {
            reconfigureHeaderForSection(0)
        }
    }

    private func applyUpdate_invalidateInSeparateBatch() {
        collectionView.performBatchUpdates {
            headers = [
                0: (30, "Section 1 -> 0 (updated)"),
            ]

            values = [values[1]]
            collectionView.deleteSections([0, 2, 3, 4])
        }
        collectionView.performBatchUpdates {
            // This does not crash, but it's another example that invalidating the layout of a
            // supplementary view does not cause it to be reconfigured.
            let context = UICollectionViewLayoutInvalidationContext()
            context.invalidateSupplementaryElements(ofKind: UICollectionView.elementKindSectionHeader, at: [IndexPath(item: 0, section: 0)])
            collectionView.collectionViewLayout.invalidateLayout(with: context)
        }
    }

    /// When invalidating the layout during the batch updates it will crash if other updates are
    /// also applied. This does **NOT** happen with a flow layout.
    private func applyUpdate_invalidateHeaderAtBeforeIndex() {
        collectionView.performBatchUpdates {
            headers = [
                0: (30, "Section 1 -> 0 (updated)"),
            ]

            values = [values[1]]
            collectionView.deleteSections([0, 2, 3, 4])

            let context = UICollectionViewLayoutInvalidationContext()
            context.invalidateSupplementaryElements(ofKind: UICollectionView.elementKindSectionHeader, at: [IndexPath(item: 0, section: 0)])
            collectionView.collectionViewLayout.invalidateLayout(with: context)
        }
    }

    /// When invalidating the layout during the batch updates it will crash if other updates are
    /// also applied. This does **NOT** happen with a flow layout.
    private func applyUpdate_invalidateHeaderAtAfterIndex() {
        collectionView.performBatchUpdates {
            headers = [
                0: (30, "Section 1 -> 0 (updated)"),
            ]

            values = [values[1]]
            collectionView.deleteSections([0, 2, 3, 4])

            let context = UICollectionViewLayoutInvalidationContext()
            context.invalidateSupplementaryElements(ofKind: UICollectionView.elementKindSectionHeader, at: [IndexPath(item: 0, section: 1)])
            collectionView.collectionViewLayout.invalidateLayout(with: context)
        }
    }

    private func applyUpdate_configureHeaderWithIndexBeforeUpdates() {
        collectionView.performBatchUpdates {
            headers = [
                0: (30, "Section 1 -> 0 (updated)"),
            ]

            values = [values[1]]
            collectionView.deleteSections([0, 2, 3, 4])

            // This uses the index before the update and results in the original header having the
            // right contents but then being removed. Remove `UIView.setAnimationsEnabled(false)`
            // from SceneDelegate.swift and enable Slow Animations to see this better.
            reconfigureHeaderForSection(0)
        }
    }

    private func applyUpdate_configureHeaderWithIndexAfterUpdates() {
        collectionView.performBatchUpdates {
            headers = [
                0: (30, "Section 1 -> 0 (updated)"),
            ]

            values = [values[1]]
            collectionView.deleteSections([0, 2, 3, 4])

            // This uses the index after the update so section 0 has a blank header
            reconfigureHeaderForSection(1)
        }
    }
}

private final class HeaderView: UICollectionReusableView {
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
