//
//  HomeViewController.swift
//  RecipeNew
//
//  Created by Shehan Udaraka on 1/15/23.
//  Copyright © 2023 Shehan Udaraka. All rights reserved.
//

import UIKit

enum Sections: Int {
    case TrendingRecipes = 0
    case Recent = 1
    case Categories = 2
    case Popular = 3
    case TopRated = 4
}



class HomeViewController: UIViewController {
    
    private var randomTrendingFood: Food?
    
    private var headerView: HeroHeaderUIView?

    
     let sectionTitles: [String] = ["Trending Recipes","Recent Recipes", "Categories", "Popular","Top rated"]
    
    private let homefeedTable: UITableView = {
        
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(homefeedTable)
        homefeedTable.delegate = self
        homefeedTable.dataSource = self
        
        configureNavbar()
        
        
        headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        homefeedTable.tableHeaderView = headerView
        configureHeroHeaderView()
        
   
    }

    
    private func configureHeroHeaderView() {

        APICaller.shared.getTrendingMovies { [weak self] result in
            switch result {
            case .success(let foods):
                let selectedTitle = foods.randomElement()
                
                self?.randomTrendingFood = selectedTitle
                self?.headerView?.configure(with: TitleViewModel(titleName: selectedTitle?.name ?? "", posterURL: selectedTitle?.image ?? ""))
                
            case .failure(let erorr):
                print(erorr.localizedDescription)
            }
        }
        
    }
    
    private func configureNavbar(){
        var image = UIImage(named: "logos")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
  
        navigationController?.navigationBar.backgroundColor = .systemOrange
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homefeedTable.frame = view.bounds
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else{
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        switch indexPath.section {
            
            case Sections.TrendingRecipes.rawValue:
                      APICaller.shared.getTrendingFood { result in
                          switch result {
                              
                          case .success(let foods):
                              cell.configure(with: foods)
                          case .failure(let error):
                              print(error.localizedDescription)
                          }
                      }
            
            case Sections.Recent.rawValue:
                
                      APICaller.shared.getRecentFoods { result in
                          switch result {
                          case .success(let foods):
                              cell.configure(with: foods)
                          case .failure(let error):
                              print(error.localizedDescription)
                         }
                     }
            
            
            
     
            
            
        default:
            return UITableViewCell()

        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .black
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}

extension HomeViewController: CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
