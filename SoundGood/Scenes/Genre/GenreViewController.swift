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
    @IBOutlet weak var genreTableView: UITableView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
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
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GenreTableViewCell = genreTableView.dequeueReusableCell(for: indexPath)
        return cell
    }
}
