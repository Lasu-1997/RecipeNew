//
//  SearchViewController.swift
//  RecipeNew
//
//  Created by Shehan Udaraka on 1/15/23.
//  Copyright © 2023 Shehan Udaraka. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    private var foods: [Food] = [Food]()

       private let discoverTable: UITableView = {
           let table = UITableView()
           table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
           return table
       }()
    
    private let searchController: UISearchController = {
           let controller = UISearchController(searchResultsController: SearchResultsViewController())
           controller.searchBar.placeholder = "Search for Your Recipe"
           controller.searchBar.searchBarStyle = .minimal
           return controller
       }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = .systemBackground
        
        view.addSubview(discoverTable)
        discoverTable.delegate = self
        discoverTable.dataSource = self
        navigationItem.searchController = searchController
        
        navigationController?.navigationBar.tintColor = .white
        fetchDiscoverMovies()
        
        searchController.searchResultsUpdater = self
    }
    
  
    
    private func fetchDiscoverMovies() {
           APICaller.shared.getDiscoverFoods { [weak self] result in
               switch result {
               case .success(let foods):
                   self?.foods = foods
                   DispatchQueue.main.async {
                       self?.discoverTable.reloadData()
                   }
               case .failure(let error):
                   print(error.localizedDescription)
               }
           }
       }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }

}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return foods.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
    
        
        let food = foods[indexPath.row]
        let model = TitleViewModel(titleName: food.name ?? food.ingredients ?? "Unknown name", posterURL: food.image ?? "")
               cell.configure(with: model)
        
        return cell;
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        
        let food = foods[indexPath.row]
        
        guard let titleName = food.name ?? food.ingredients else {
            return
        }

        
        APICaller.shared.getFood(with: titleName) { [weak self] result in
                  switch result {
                  case .success(let videoElement):
                      DispatchQueue.main.async {
                          let vc = TitlePreviewViewController()
                        vc.configure(with: TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: food.ingredients ?? ""))
                          self?.navigationController?.pushViewController(vc, animated: true)
                      }

                      
                  case .failure(let error):
                     print(error.localizedDescription)
                 }
              }
    }
}

extension SearchViewController: UISearchResultsUpdating, SearchResultsViewControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? SearchResultsViewController else {
                  return
              }
        resultsController.delegate = self
        

        
        APICaller.shared.search(with: query) { result in
                  DispatchQueue.main.async {
                      switch result {
                      case .success(let foods):
                          resultsController.foods = foods
                          resultsController.searchResultsCollectionView.reloadData()
                      case .failure(let error):
                         print(error.localizedDescription)
                     }
                 }
             }
    }
    
    
    
    func searchResultsViewControllerDidTapItem(_ viewModel: TitlePreviewViewModel) {
        
            DispatchQueue.main.async { [weak self] in
           let vc = TitlePreviewViewController()
           vc.configure(with: viewModel)
           self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
