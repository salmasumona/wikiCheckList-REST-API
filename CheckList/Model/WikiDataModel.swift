//
//  ArticleModel.swift
//  CheckList
//
//  Created by Sumona Salma on 4/14/19.
//  Copyright © 2019 Sumona Salma. All rights reserved.
//

import Foundation

//struct WikiData: Decodable {
//    let id: Int
//    let name: String
//   // let description: Int
//}

struct WikiData: Codable {
    var batchcomplete: String
    var query: Query
}
struct Query: Codable
{
    var search: [PageData]?
}

struct PageData: Codable {
    var pageid: Int
    var ns: Int
    var title: String
    var snippet: String
    var timestamp: String
}

