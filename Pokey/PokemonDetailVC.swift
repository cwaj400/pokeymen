//
//  PokemonDetailVC.swift
//  Pokey
//
//  Created by William on 15/04/2021.
//

import Foundation

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher;

class PokemonDetailVC: UIViewController {
    
    var pokemon : Pokeyone!;
    var inPokemonDetailVC:Bool!;
    
    @IBOutlet weak var name: UILabel!
    
    
    @IBOutlet weak var sprite: UIImageView!
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        
        
        pokemon = Pokeyone(name: " ", number: " ");
        
        DispatchQueue.main.async {
            if self.inPokemonDetailVC {
                self.inPokemonDetailVC = !self.inPokemonDetailVC;
                
                self.setURL();
            }
        }
        
    }
    
    //MARK:- Utility Functions
    
    func setURL() {
        var result = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/";
        
        result.append("\(pokemon.number)")
        result.append(".png");

        let resultURL = URL(string: result);
        self.sprite.kf.setImage(with: resultURL)
        print(resultURL!);
        //self.sprite.setImage(with: result)
        //self.sprite.kf.setImage(with: resultURL);

    }
}
