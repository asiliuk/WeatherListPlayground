import UIKit

public final class AsiliukMVVMViewController: UIViewController {
    // MARK: View Model
    private let viewModel: AsiliukMVVMViewModel

    // MARK: Collection View
    private lazy var collectionViewLayoutConfig: UICollectionLayoutListConfiguration = {
        var configuration = UICollectionLayoutListConfiguration(appearance:
                .insetGrouped)
        configuration.footerMode = .supplementary
        return configuration
    }()

    private lazy var collectionViewLayout = UICollectionViewCompositionalLayout.list(using: collectionViewLayoutConfig)
    private lazy var collectionView = UICollectionView(frame: view.frame, collectionViewLayout: collectionViewLayout)

    // MARK: Data Source
    private enum Section: CaseIterable {
        case main
    }

    private let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, AsiliukMVVMViewModel.RowState>
    { cell, indexPath, rowState in
        var content = cell.defaultContentConfiguration()
        content.text = rowState.title
        content.secondaryText = rowState.subtitle
        cell.contentConfiguration = content
    }

    private lazy var supplementaryRegistration = UICollectionView.SupplementaryRegistration<UICollectionViewListCell>(
        elementKind: "show_more_footer"
    ) { [showMoreButton] cell, _, indexPath in
        showMoreButton.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        cell.contentView.addSubview(showMoreButton)
        NSLayoutConstraint.activate([
            showMoreButton.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            showMoreButton.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            showMoreButton.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            showMoreButton.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
        ])
    }

    private lazy var dataSource = UICollectionViewDiffableDataSource<Section, AsiliukMVVMViewModel.RowState>(
        collectionView: collectionView
    ) { (collectionView, indexPath, rowState) -> UICollectionViewCell? in
        collectionView.dequeueConfiguredReusableCell(
            using: self.cellRegistration,
            for: indexPath,
            item: rowState
        )
    }

    // MARK: Show more
    private lazy var showMoreButton: UIButton = {
        var configuration = UIButton.Configuration.borderless()
        configuration.title = "Show more"
        let button = UIButton(configuration: configuration)
        button.addTarget(self, action: #selector(showMoreButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: Life Cycle
    public init(viewModel: AsiliukMVVMViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
}

// MARK: - Bind

private extension AsiliukMVVMViewController {
    func setupUI() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        showMoreButton.translatesAutoresizingMaskIntoConstraints = false
        collectionView.addSubview(showMoreButton)
        NSLayoutConstraint.activate([
            showMoreButton.leadingAnchor.constraint(equalTo: collectionView.frameLayoutGuide.leadingAnchor),
            showMoreButton.trailingAnchor.constraint(equalTo: collectionView.frameLayoutGuide.trailingAnchor),
            showMoreButton.bottomAnchor.constraint(equalTo: collectionView.contentLayoutGuide.topAnchor),
        ])

        dataSource.supplementaryViewProvider = { collectionView, elementKind, indexPath in
            collectionView.dequeueConfiguredReusableSupplementary(
                using: self.supplementaryRegistration,
                for: indexPath
            )
        }
    }

    func bindViewModel() {
        updateUI()
        viewModel.viewModelDidChange = { [weak self] in self?.updateUI() }
    }

    func updateUI() {
        title = viewModel.title

        var snapshot = NSDiffableDataSourceSnapshot<Section, AsiliukMVVMViewModel.RowState>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(viewModel.visibleRows)
        dataSource.apply(snapshot, animatingDifferences: true)

        showMoreButton.isHidden = !viewModel.isShowMoreButtonShown
    }

    @objc func showMoreButtonTapped() {
        viewModel.showMoreButtonTapped()
    }
}
