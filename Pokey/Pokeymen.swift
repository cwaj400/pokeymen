//
//  Pokeymen.swift
//  pokey
//
//  Created by William on 13/04/2021.
//

import Foundation

//https://appicon.co
struct Pokeyone: Codable {
    let name: String;
    let number: String;
    
    init(name : String, number : String) {
        self.name = name;
        self.number = number;
    }
}
