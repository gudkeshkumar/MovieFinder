//
//  MoviesSearchViewController.swift
//  MovieFinder
//
//  Created by apple on 01/04/21.
//

import UIKit
import SnapKit

class MovieSearchViewController: UIViewController {
    
    private struct Constants {
        static let insets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        static let interItemSapcing: CGFloat = 16
        static let lineSapcing: CGFloat = 16
    }
    
    private var searchText: String = ""
    private var isLoading = false
    lazy var loadingView: LoadingView = {
        LoadingView.loadFromNib()
    }()
    
    var presenter: MovieSearchPresenter?
    
    private lazy var searchDebouncer: Debouncer = {
        let debouncer = Debouncer(delay: 0.5) {[weak self] in
            guard let self = self else { return }
            print(self.searchText)
            self.presenter?.fetchMovies(for: self.searchText)
        }
        return debouncer
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = Constants.interItemSapcing
        layout.minimumLineSpacing = Constants.lineSapcing
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        collection.register(MovieCollectionViewCell.self)
        collection.contentInset = Constants.insets
        return collection
    }()
    
    private lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.placeholder = "Search"
        search.searchResultsUpdater = self
        search.searchBar.isTranslucent = false
        search.searchBar.searchBarStyle = .prominent
        search.obscuresBackgroundDuringPresentation = false
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        build()
    }
    
}

private extension MovieSearchViewController {
    
    func setup() {
        title = "Movies"
        view.backgroundColor = .systemBackground
        navigationItem.searchController = searchController
        collectionView.backgroundColor = .systemGray
        loadingView.backgroundColor = .red
        loadingView.isHidden = true
    }
    
    func build() {
        buildHeirarchy()
        buildConstraints()
    }
    
    func buildHeirarchy() {
        view.addSubview(collectionView)
        view.addSubview(loadingView)
    }
    
    func buildConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        loadingView.snp.makeConstraints { (make) in
            make.height.equalTo(44)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}

extension MovieSearchViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.numberOfItemsInSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let model = presenter?.movie(at: indexPath), let mCell = cell as? MovieCollectionViewCell else { return }
        mCell.update(with: model)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(index: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellwidth = (collectionView.frame.width - 48) / 2
        let cellHeight = collectionView.frame.height / 2
        return CGSize(width: cellwidth, height: cellHeight)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height && !isLoading && presenter?.numberOfItemsInSection() != 0 {
            isLoading = true
            print(" you reached end of the table")
            presenter?.loadMore(for: searchText)
            
        }
    }
}

extension MovieSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        searchText = text
        searchDebouncer.debounce()
    }
}

//MARK: View behaviour
extension MovieSearchViewController: MoviePresenterToViewProtocol {
    func onMoviesFetchSuccess(_ reload: Bool) {
        guard reload else {
            return
        }
        collectionView.reloadData()
    }
    
    func onMoviesFetchFailure(error: String?) {
        showAlert(title: "Error", message: error ?? "Unknown error")
    }
    
    func startLoading() {
        isLoading = true
        loadingView.isHidden = false
        loadingView.activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        isLoading = false
        loadingView.isHidden = true
        loadingView.activityIndicator.stopAnimating()
    }
}
