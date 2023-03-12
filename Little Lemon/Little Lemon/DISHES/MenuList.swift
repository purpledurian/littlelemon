//
//  MenuList.swift
//  Little Lemon
//
//  By: S.Mayer
//

import Foundation

struct MenuList: Codable {
    // add code here
    let menu:[MenuItem]
    
    enum CodingKeys: String, CodingKey {
            case menu = "menu"
        }
     
    
}
