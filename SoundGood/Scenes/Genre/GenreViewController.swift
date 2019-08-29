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
    @IBOutlet private weak var genreSearchBar: UISearchBar!

    // MARK: - Variables
    private let viewModel: GenreViewModel = {
        let local = GenreLocalDataSource()
        let repository = GenreDataRepository(localDataSource: local)
        let viewModel = GenreViewModel(repository: repository)
        return viewModel
    }()
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
        genreSearchBar.delegate = self
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

    private func navigateToTrackByGenre(with data: Genre) {
        guard let controller = Storyboards.trackByGenre.instantiateInitialViewController() as? TrackByGenreViewController else { return }
        controller.genreTitle = data.title
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
        tableView.deselectRow(at: indexPath, animated: true)
        navigateToTrackByGenre(with: filteredGenres[indexPath.row])
    }
}

// MARK: - SearchBar delegate
extension GenreViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredGenres = filterData(genres, with: searchText)
        genreTableView.reloadData()
    }

    private func filterData(_ genres: [Genre], with keyword: String) -> [Genre] {
        if keyword.isEmpty {
            return genres
        }
        return genres.filter {
            $0.title.lowercased().contains(keyword.lowercased())
        }
    }
}
