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
    private var titles = [String]()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        titles = viewModel.getGenreTitles(genres: Constant.genres)
        titles.sort()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.topItem?.title = "Genre"
    }

    private func setupTableView() {
        genreTableView.dataSource = self
        genreTableView.register(cellType: GenreTableViewCell.self)
    }
}

// MARK: - TableView data source
extension GenreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GenreTableViewCell = genreTableView.dequeueReusableCell(for: indexPath)
        cell.setup(title: titles[indexPath.row])
        return cell
    }
}
