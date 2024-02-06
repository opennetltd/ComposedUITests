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
                title: "[Composed] Update → Insert → Update → Remove → Update",
                viewControllerFactory: TestUpdateInsertUpdateRemoveUpdateCollectionViewController()
            ),
            ComposedTest(
                title: "[Manual] Update → Insert → Update → Remove → Update",
                viewControllerFactory: TestUpdateInsertUpdateRemoveUpdateCollectionViewControllerManual()
            ),
        ])
        rootSection.testSelectionHandler = { [unowned self] test in
            let viewController = test.viewControllerFactory()
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        collectionCoordinator = CollectionCoordinator(collectionView: collectionView, sections: rootSection)
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
        size.height = 32
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
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
