//
//  SearchViewController.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 8/28/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var trackSearchBar: UISearchBar!
    @IBOutlet private weak var trackResultTableView: UITableView!

    // MARK: - Variables
    private let viewModel: SearchViewModel = {
        let remote = TrackRemoteDataSource(apiService: ApiService.shared)
        let repository = TrackDataRepository(remoteDataSource: remote)
        let viewModel = SearchViewModel(repository: repository)
        return viewModel
    }()
    private var compositeDisposable = CompositeDisposable()
    private var searchedTracks = [Track]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
        observeData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = "Search"
    }

    deinit {
        viewModel.trackObservable.dispose()
    }

    private func setupSearchBar() {
        trackSearchBar.delegate = self
    }

    private func setupTableView() {
        trackResultTableView.dataSource = self
        trackResultTableView.delegate = self
        trackResultTableView.register(cellType: TrackTableViewCell.self)
    }

    private func observeData() {
        let observer: Observable<BaseResult<SearchResponse>>.Observer = { [weak self] result in
            guard let response = result else { return }
            switch response {
            case .success(let searchResponse):

                guard let collection = searchResponse?.collection else { return }
                let data = collection.map { $0 }
                self?.updateTracks(data: data)
            case .failure(let error):
                guard let error = error else { return }
                self?.showErrorAlert(message: error.errorMessage)
            }
        }
        viewModel.trackObservable.subscribe(on: DispatchQueue.main, observer).add(to: &compositeDisposable)
    }

    private func updateTracks(data: [Track]) {
        searchedTracks = data
        trackResultTableView.reloadData()
    }
}

// MARK: - TableView DataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedTracks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = trackResultTableView.dequeueReusableCell(for: indexPath) as TrackTableViewCell
        if searchedTracks.indices.contains(indexPath.row) {
            cell.setup(track: searchedTracks[indexPath.row])
        }
        return cell
    }
}

// MARK: - TableView Delegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(TableViewConstant.heightForTableViewCell)
    }
}

// MARK: - SearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(searchRequest(_:)), object: searchBar)
        perform(#selector(searchRequest(_:)), with: searchBar, afterDelay: Constant.searchDelay)
    }

    @objc func searchRequest(_ searchBar: UISearchBar) {
        trackResultTableView.isHidden = searchBar.text?.isEmpty ?? true
        guard let query = searchBar.text, !query.isEmpty else {
            return
        }
        viewModel.searchTracks(with: query)
    }
}
