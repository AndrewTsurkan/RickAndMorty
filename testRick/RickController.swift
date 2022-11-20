//
//  ViewController.swift
//  testRick
//
//  Created by Андрей Цуркан on 16.11.2022.
//

import UIKit

class RickController: UIViewController {
    
    private let table = UITableView()
    private let networkDataFetcher = NetworkDataFetcher()
    private var networkService = NetworkService()
    private var ricks: [ResponseResult] = []
    private var counter: Int = 1
    private var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
        table.separatorColor = .white
        
        setupTableView()
        loadData()
    }
    
    func setupTableView() {
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(RickInfoCell.self, forCellReuseIdentifier: RickInfoCell.reusedId)
        
        [table.topAnchor.constraint(equalTo: view.topAnchor),
         table.leftAnchor.constraint(equalTo: view.leftAnchor),
         table.rightAnchor.constraint(equalTo: view.rightAnchor),
         table.bottomAnchor.constraint(equalTo: view.bottomAnchor)].forEach{$0.isActive = true}
    }
    private func loadData(){
        let urlString: String = "https://rickandmortyapi.com/api/character"
        networkDataFetcher.fetchJson(urlString: urlString) { [weak self] result in
            switch result {
            case let .success(info):
                self?.ricks = info
                DispatchQueue.main.async {
                    self?.table.reloadData()
                }
            case .failure:
                // TODO: Error handling
                break
            }
        }
    }
}

extension RickController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ricks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RickInfoCell.reusedId, for: indexPath) as? RickInfoCell else {
            return UITableViewCell()
        }
        let rick = ricks[indexPath.row]
        cell.responseResult = rick
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == ricks.count - 1 {
            counter += 1
            let urlString = "https://rickandmortyapi.com/api/character?page=\(String(counter))"
            networkDataFetcher.fetchJson(urlString: urlString) { [weak self] result in
                switch result {
                case let .success(info):
                    self?.ricks.append(contentsOf: info)
                    DispatchQueue.main.async {
                        self?.table.reloadData()
                    }
                case .failure:
                    // TODO: Error handling
                    break
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Action
        tableView.deselectRow(at: indexPath, animated: true)
    }
}




