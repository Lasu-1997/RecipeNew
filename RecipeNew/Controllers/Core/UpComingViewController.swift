//
//  UpComingViewController.swift
//  RecipeNew
//
//  Created by Shehan Udaraka on 1/15/23.
//  Copyright © 2023 Shehan Udaraka. All rights reserved.
//

import UIKit

class UpComingViewController: UIViewController {
    
    
    private var foods: [Food] = [Food]()
    
    private let upcomingTable: UITableView = {
       
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Explore"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(upcomingTable)
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
        
        fetchUpcoming()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTable.frame = view.bounds
    }
    
 
    
    private func fetchUpcoming() {
          APICaller.shared.getRecentFoods { [weak self] result in
              switch result {
              case .success(let foods):
                  self?.foods = foods
                  DispatchQueue.main.async {
                      self?.upcomingTable.reloadData()
                  }
                  
              case .failure(let error):
                  print(error.localizedDescription)
              }
          }
      }
    
}

extension UpComingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        
        let food = foods[indexPath.row]
        
        cell.configure(with: TitleViewModel(titleName: (food.name ?? food.ingredients) ?? "Unknown title name", posterURL: food.image ?? ""))
        
        return cell
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
                       vc.configure(with: TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: title.overview ?? ""))
                       self?.navigationController?.pushViewController(vc, animated: true)
                   }

                   
               case .failure(let error):
                   print(error.localizedDescription)
               }
           }
       }

}
