//
//  ViewController.swift
//  testRick
//
//  Created by Андрей Цуркан on 16.11.2022.
//

import UIKit

class RickController: UIViewController {
    private let table = UITableView()
    private var installCell: InstallCell? = nil
    private let networkDataFetcher = NetworkDataFetcher()
    private var networkService = NetworkService()
    var ricks: [ResponseResult] = []
    private var counter:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.table.separatorColor = .white
        
        installTableView()
        loadData()
    }
    
    func installTableView() {
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(InstallCell.self, forCellReuseIdentifier: InstallCell.reusedId)
        
        [table.topAnchor.constraint(equalTo: view.topAnchor),
         table.leftAnchor.constraint(equalTo: view.leftAnchor),
         table.rightAnchor.constraint(equalTo: view.rightAnchor),
         table.bottomAnchor.constraint(equalTo: view.bottomAnchor)].forEach{$0.isActive = true}
    }
    private func loadData(){
        let urlString: String = "https://rickandmortyapi.com/api/character"
        networkDataFetcher.fetchJson(urlString: urlString) { [weak self] info in
            guard let info = info else { return }
            self?.ricks = info
            DispatchQueue.main.async {
                self?.table.reloadData()
            }
        }
    }
}

extension RickController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ricks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InstallCell.reusedId, for: indexPath) as? InstallCell else {
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
            networkDataFetcher.fetchJson(urlString: urlString) { [weak self] info in
                guard let info = info else { return }
                self?.ricks.append(contentsOf: info)
                DispatchQueue.main.async {
                    self?.table.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}




