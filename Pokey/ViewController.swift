//
//  ViewController.swift
//  Pokey
//
//  Created by William on 14/04/2021.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK:- Outlets
    
    @IBOutlet var tableView: UITableView!
    var pokemen : [String] = [];
    //let customAPI = CustomPokemonAPI();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView?.reloadData();
        
        fetchAllPokemen();
    }
    

    
    //MARK:- SETUP.
    //TableViewDataSource inherited method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return pokemen.count;
    }
    
    //TableViewDataSource inherited method
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = pokemen[indexPath.row];
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(pokemen[indexPath.row]);
    }
    
    
    //MARK:- NAVIGATION
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //https://developer.apple.com/forums/thread/105156
        if (segue.identifier == "onPokemonClick") {
            
            if let indexPath = tableView.indexPathForSelectedRow{
                let selectedRow = indexPath.row
                let detailVC = segue.destination as! PokemonDetailVC
                //https://stackoverflow.com/questions/44324595/difference-between-dispatchqueue-main-async-and-dispatchqueue-main-sync
                DispatchQueue.main.async {
                    detailVC.name.text = self.pokemen[selectedRow]
                }
            }
        }
    }
    
    
    
    //MARK:- UTILITY FUNCTIONS
    
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
