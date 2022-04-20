//
//  Article.swift
//  NewsForYou
//
//  Created by Asif on 21/1/22.
//

import Foundation

struct ArticleList : Codable{
    let articles : [Article]
}

struct Article : Codable{
    let title : String?
    let description : String?
}
