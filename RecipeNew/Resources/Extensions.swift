//
//  Extensions.swift
//  RecipeNew
//
//  Created by Shehan Udaraka on 1/25/23.
//  Copyright © 2023 Shehan Udaraka. All rights reserved.
//

import Foundation

extension String{
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
