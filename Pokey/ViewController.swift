//
//  ViewController.swift
//  Pokey
//
//  Created by William on 14/04/2021.
//

import UIKit
import Alamofire
import SwiftyJSON
import Foundation
import Kingfisher

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    //MARK:- Outlets
    @IBOutlet var tableView: UITableView!
    
    //MARK:- Variables
    var filteredData: [String]! = [];
    var searchController: UISearchController!;
    var pokemen : [Pokeyone] = [];
    var pokemenNames : [String] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self;
        tableView.dataSource = self;

        // I programatically created a search bar because it made filtering results using updateSearchResults() much easier.
        searchController = UISearchController(searchResultsController: nil);
        searchController.searchResultsUpdater = self;
        
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar;
        
        definesPresentationContext = true
        fetchAllPokemen();
        
        tableView?.reloadData();
    }
    
    
    //MARK:- SETUP.
    // TableViewDataSource inherited method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        // Return data filtered from the search bar.
        return filteredData.count;
    }
    
    // TableViewDataSource inherited method
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = filteredData[indexPath.row];
        cell.imageView?.image = UIImage(named: "pokeball")
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //EMPTY.
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
                    detailVC.pokemon = self.pokemen[selectedRow];
                    detailVC.name.text = self.pokemenNames[selectedRow]
                    detailVC.inPokemonDetailVC = true;
                }
            }
        }
    }
    
    
    //MARK:- UTILITY FUNCTIONS
    func fetchAllPokemen() {
        
        // AlamoFire runs validation on it's own side, so I do not need to concern myself with 200 response calls. .validate() does this for me. I thought about creating a dedicated service but decided against it for this task as it seemed overkill.
        AF.request("https://pokeapi.co/api/v2/pokemon").validate().responseJSON { response in
            DispatchQueue.main.async {
                // I tried creating a completion handler here but failed for some reason. This seems like a suitable work-around.
                // Once data has been fetched, I set filteredData (the main viewing data) as a duplicate to pokemon array.
                self.filteredData = self.pokemenNames
                self.tableView.reloadData();
            }
            
            let json = JSON(response.value!);
            let jsonResult = JSON(json["results"]);
            
            for (_, subJson):(String, JSON) in jsonResult {
                
                let specificURL = subJson["url"].string!;
                let name = subJson["name"].string!;
                self.pokemenNames.append(name.capitalized)
                
                // Parse pokemon number from URL. I could have used a key in the above for, but the server side could change the digits around for some mad reason, and this would break my code.
                let numberOfPoke  = specificURL.suffix(3).replacingOccurrences(of: "/", with: "");
                
                var front = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/";
                front.append(String(numberOfPoke));
                front.append(".png");
                
                let newPokemon = Pokeyone(name: name, number: String(numberOfPoke), imageURL: front)
                

                self.pokemen.append(newPokemon);
            }
            
        }
        
    }
    
    //https://stackoverflow.com/questions/41663233/tableview-search-in-swift
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            // I am using another array, filteredData here because I did not want to manipulate the original array I populated.
            // If I lost that data for some reason as a result of my filter, I would have to call the fetch again which would be a data hog.
            filteredData = searchText.isEmpty ? pokemenNames : pokemenNames.filter({(dataString: String) -> Bool in
                
                tableView.reloadData();
                return dataString.range(of: searchText, options: .caseInsensitive) != nil;
            })
            tableView.reloadData();
        }
    }

}
