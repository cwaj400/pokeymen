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
}


struct Pokeymany : Decodable {
    let results: [Pokeyone];
    
}

class Api {
    func getPokemon() {
        //using guard as swift is typesafe. specify type. return in else.
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let jsonData = try! JSONDecoder().decode([Pokeyone].self, from: data!)
            print(jsonData)
        
        }
        .resume();
    }
}
