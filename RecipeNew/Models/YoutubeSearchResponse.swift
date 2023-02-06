//
//  YoutubeSearchResponse.swift
//  RecipeNew
//
//  Created by Shehan Udaraka on 2/2/23.
//  Copyright © 2023 Shehan Udaraka. All rights reserved.
//

import UIKit

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}


struct VideoElement: Codable {
    let id: IdVideoElement
}


struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
