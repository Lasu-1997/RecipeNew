//
//  Food.swift
//  RecipeNew
//
//  Created by Shehan Udaraka on 2/4/23.
//  Copyright © 2023 Shehan Udaraka. All rights reserved.
//

import Foundation

struct TrendingFoodResponse: Codable {
    let data: [Food]
}

struct Food: Codable{
   let id: Int
   let name: String?
   let ingredients: String?
   let description: String?
   let image: String?
   let calorie_count: Int
   let created_at: String?
   let updated_at: String?
}
