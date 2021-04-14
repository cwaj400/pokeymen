//
//  ViewController.swift
//  Pokey
//
//  Created by William on 14/04/2021.
//

import UIKit
import PokemonAPI
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var pokemen : [String] = [];
    let pokemonAPI = PokemonAPI()
    //let customAPI = CustomPokemonAPI();

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self;
        tableView.dataSource = self;
        
        fetchAllPokemen();
    }
    
    func fetchAllPokemen() {
        //TODO:- add headers etc.
        
        AF.request("https://pokeapi.co/api/v2/pokemon").validate().responseJSON { response in
            DispatchQueue.main.async {
                self.tableView.reloadData();
            }
            
            let json = JSON(response.value!);
            let jsonResult = JSON(json["results"]);
            
            for (_, subJson):(String, JSON) in jsonResult {
                
                self.pokemen.append(subJson["name"].string!);
            }
            
        }
        
    }
}
        
extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(pokemen[indexPath.row]);
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(pokemen.count)
        return pokemen.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("hit here")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = pokemen[indexPath.row];
        return cell;
    }
}
