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
    private var genres = [Genre]()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getData()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.topItem?.title = "Genre"
    }

    private func setupTableView() {
        genreTableView.dataSource = self
        genreTableView.register(cellType: GenreTableViewCell.self)
    }

    private func getData() {
        genres = viewModel.getGenres()
        genres.sort {
            $0.title < $1.title
        }
    }
}

// MARK: - TableView data source
extension GenreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GenreTableViewCell = genreTableView.dequeueReusableCell(for: indexPath)
        cell.setup(title: genres[indexPath.row].title)
        return cell
    }
}
