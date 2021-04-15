//
//  Service.swift
//  Pokey
//
//  Created by William on 15/04/2021.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol Service {
    var pokemen : [Pokeyone] = [];
    
    func fetchAllPokemen() -> [Pokeyone] {
    
    
    
        //TODO:- add headers etc.
        
        // AlamoFire runs validation on it's own side, so I do not need to concern myself with 200 response calls. .validate() does this for me.
        AF.request("https://pokeapi.co/api/v2/pokemon").validate().responseJSON { response in
            DispatchQueue.main.async {
                //I tried creating a completion handler here but failed for some reason. This seems like a suitable work-around.
                //Once data has been fetched, I set filteredData (the main viewing data) as a duplicate to pokemon array.
                self.filteredData = self.pokemenNames
                self.tableView.reloadData();
            }
            
            let json = JSON(response.value!);
            let jsonResult = JSON(json["results"]);
            
            for (_, subJson):(String, JSON) in jsonResult {
                
                //TODO:- Type safe checks.
                self.pokemenNames.append(subJson["name"].string!);
                
                let specificURL = subJson["url"].string!;
                let name = subJson["name"].string!;
                
                let numberOfPoke  = specificURL.suffix(3);
                print(numberOfPoke)
                self.pokemen.append(Pokeyone(name: name, number: String(numberOfPoke)));
            }
            
        }
        
    }
    
}
