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
    var imageURL = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/");
    
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
                print("done")
            }
            
            
            print("in new vc")
        }
    }
    
    //MARK:- Utility Functions
    
    func setURL() {
        self.imageURL?.appendPathComponent(self.pokemon?.number ?? "1.png");
        self.imageURL?.appendPathComponent(".png/");
        
        self.sprite.kf.setImage(with: self.imageURL);
        
        print(self.pokemon?.name)
        
        self.name.text = ""
        print(imageURL?.absoluteURL)

    }
}
