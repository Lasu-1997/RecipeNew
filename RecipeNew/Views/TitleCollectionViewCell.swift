//
//  TitleCollectionViewCell.swift
//  RecipeNew
//
//  Created by Shehan Udaraka on 1/28/23.
//  Copyright © 2023 Shehan Udaraka. All rights reserved.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TitleCollectionViewCell"
    
    private let posterImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    public func configure(with model: String){
     
        
        guard let url = URL(string: model) else {
            return
        }
        posterImageView.sd_setImage(with: url, completed: nil)
        //print(model)
    
    }
    
}
