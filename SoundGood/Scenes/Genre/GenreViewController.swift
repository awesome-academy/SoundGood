//
//  GenreViewController.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 8/26/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import UIKit

class GenreViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var genreTableView: UITableView!

    // MARK: - Variables
    private let viewModel: GenreViewModel = {
        let local = GenreLocalDataSource()
        let repository = GenreDataRepository(localDataSource: local)
        let viewModel = GenreViewModel(repository: repository)
        return viewModel
    }()
    private let searchController = UISearchController(searchResultsController: nil)
    private var genres = [Genre]()
    private var filteredGenres = [Genre]()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
        getData()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.topItem?.title = "Genre"
    }

    private func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        genreTableView.tableHeaderView = searchController.searchBar
    }

    private func setupTableView() {
        genreTableView.dataSource = self
        genreTableView.delegate = self
        genreTableView.register(cellType: GenreTableViewCell.self)
    }

    private func getData() {
        genres = viewModel.getGenres()
        genres.sort {
            $0.title < $1.title
        }
        filteredGenres = genres
    }

    private func navigateToTrackByGenre(with cell: GenreTableViewCell) {
        guard let controller = Storyboards.trackByGenre.instantiateInitialViewController() as? TrackByGenreViewController else { return }
        controller.genreTitle = cell.getGenreTitle()
        guard let view = navigationController?.view else { return }
        UIView.transition(with: view, duration: 0.2, options: .transitionCrossDissolve, animations: nil, completion: nil)
        navigationController?.pushViewController(controller, animated: false)
    }
}

// MARK: - TableView data source
extension GenreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGenres.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GenreTableViewCell = genreTableView.dequeueReusableCell(for: indexPath)
        cell.setup(title: filteredGenres[indexPath.row].title)
        return cell
    }
}

// MARK: - TableView delegate
extension GenreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = genreTableView.cellForRow(at: indexPath) as? GenreTableViewCell else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        navigateToTrackByGenre(with: cell)
    }
}

// MARK: - SearchBar delegate
extension GenreViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        if searchText.isEmpty {
            filteredGenres = genres
        } else {
            filteredGenres = genres.filter {
                $0.title.lowercased().contains(searchText.lowercased())
            }
        }
        genreTableView.reloadData()
    }
}
