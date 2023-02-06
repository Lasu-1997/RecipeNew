//
//  TitlePreviewViewController.swift
//  RecipeNew
//
//  Created by Shehan Udaraka on 2/2/23.
//  Copyright © 2023 Shehan Udaraka. All rights reserved.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {
    
    private let titleLabel: UILabel = {
          
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.font = .systemFont(ofSize: 22, weight: .bold)
           label.text = "String Hoppers"
           return label
       }()
    
    private let overviewLabel: UILabel = {
         
          let label = UILabel()
          label.font = .systemFont(ofSize: 18, weight: .regular)
          label.translatesAutoresizingMaskIntoConstraints = false
          label.numberOfLines = 0
          label.text = "This is the best recipe app for u!!"
          return label
      }()
    
    private let downloadButton: UIButton = {
          
           let button = UIButton()
           button.translatesAutoresizingMaskIntoConstraints = false
           button.backgroundColor = .red
           button.setTitle("Favourite", for: .normal)
           button.setTitleColor(.white, for: .normal)
           button.layer.cornerRadius = 8
           button.layer.masksToBounds = true
           
           return button
       }()
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

         view.backgroundColor = .systemBackground
         view.addSubview(webView)
         view.addSubview(titleLabel)
         view.addSubview(overviewLabel)
         view.addSubview(downloadButton)
        
        configureConstraints()
        
       // downloadButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    func configureConstraints() {
           let webViewConstraints = [
               webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
               webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               webView.heightAnchor.constraint(equalToConstant: 300)
           ]
           
           let titleLabelConstraints = [
               titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
               titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
           ]
           
           let overviewLabelConstraints = [
               overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
               overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
           ]
           
           let downloadButtonConstraints = [
               downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 25),
               downloadButton.widthAnchor.constraint(equalToConstant: 140),
               downloadButton.heightAnchor.constraint(equalToConstant: 40)
           ]
           
           NSLayoutConstraint.activate(webViewConstraints)
           NSLayoutConstraint.activate(titleLabelConstraints)
           NSLayoutConstraint.activate(overviewLabelConstraints)
           NSLayoutConstraint.activate(downloadButtonConstraints)
           
       }
    
    public func configure(with model: TitlePreviewViewModel) {
           titleLabel.text = model.title
           overviewLabel.text = model.titleOverview
           
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else {
            return
        }
           
           webView.load(URLRequest(url: url))
       }
    
    //@objc func loginButtonTapped() {
    
    //nish
    //let token = UserDefaults.standard.string(forKey: "token")
    //if (token == nil){
   //redirect to login
//}else{
    //add to favorites
//}
    
    
      //         let loginViewController = LoginViewController()
        //       UIView.transition(with: UIApplication.shared.windows.first!, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                   //  UIApplication.shared.windows.first?.rootViewController = //loginViewController
        //         }, completion: nil)
      //     }
    

  

}
