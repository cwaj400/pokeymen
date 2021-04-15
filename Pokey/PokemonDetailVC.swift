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

    @IBOutlet weak var name: UILabel!
    let imageURL = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1.png");
    
    @IBOutlet weak var sprite: UIImageView!
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        sprite.kf.setImage(with: imageURL);
        
        self.name.text = ""
        print("in pokemon details")
        //blah
    }
    
}
