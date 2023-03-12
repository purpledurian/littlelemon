//
//  MenuItem.swift
//  Little Lemon
//
//  By: S.Mayer
//


import Foundation

struct MenuItem: Codable, Identifiable {
    let id = UUID()
    
    // add code here
    let title: String
    let price: String
    let image: String
    let description: String
    let category: String
    
    enum CodingKeys: String, CodingKey {
            case title = "title"
            case price = "price"
            case image = "image"
            case description = "description"
            case category = "category"
    }
}
