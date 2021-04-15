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
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var name: UILabel!
    
    var imgTick : Int = 0;
    
    var pokemonImagesArr : [String]!;
    
    @IBOutlet weak var sprite: UIImageView!
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        var front = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/";
        front.append("\(self.pokemon.number)")
        front.append(".png");

        var back = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/";
        back.append("\(self.pokemon.number)")
        back.append(".png");
        self.pokemonImagesArr = [front, back];
        Timer.scheduledTimer(timeInterval: 0.3,
                                 target: self,
                                 selector: #selector(self.changeView),
                                 userInfo: nil,
                                 repeats: true)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        
        pokemon = Pokeyone(name: " ", number: " ");
        
        DispatchQueue.main.async {
            if self.inPokemonDetailVC {
                self.inPokemonDetailVC = !self.inPokemonDetailVC;
            }
        }
        
    }
    
    //MARK:- Utility Functions
    
    @objc func changeView() {
        // Tiny bit of maths. imgTick is set to 0 initially, so view is pokemon back. 0 mod 2 is 0, so the pokemon image gets set to back.
        // Then imgTick gets incremented by one. when imgTick is 1, result gets set to 1, and then the front is set. I am using third party dependency Kingfisher to set the image view here.
        var result = self.imgTick % 2;
        let st = pokemonImagesArr[result];
        let resultURL = URL(string: st);
        self.sprite.kf.setImage(with: resultURL);
        self.imgTick += 1
    }
}
