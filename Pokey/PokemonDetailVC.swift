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
    
    //MARK:- Outlets.
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var sprite: UIImageView!
    
    //MARK:- Variables.
    var pokemon : Pokeyone!;
    var abilityNames : [String] = [];
    var inPokemonDetailVC:Bool!;
    var imgTick : Int = 0;
    var pokemonImagesArr : [String]!;
    
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
        
        // Timer used for Pokemon animation.
        Timer.scheduledTimer(timeInterval: 0.4,
                                 target: self,
                                 selector: #selector(self.changeView),
                                 userInfo: nil,
                                 repeats: true)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        pokemon = Pokeyone(name: " ", number: " ", imageURL: " ");
        
        DispatchQueue.main.async {
            // Practical boolean helper which I ended up not using.
            if self.inPokemonDetailVC {
                self.inPokemonDetailVC = !self.inPokemonDetailVC;
                
            }
            self.getAbilityNames();
        }
        
    }
    
    //MARK:- Utility Functions
    @objc func changeView() {
        // Tiny bit of maths. imgTick is set to 0 initially, so view is pokemon back. 0 mod 2 is 0, so the pokemon image gets set to back.
        // Then imgTick gets incremented by one. when imgTick is 1, result gets set to 1, and then the front is set. I am using third party dependency Kingfisher to set the image view here.
        let result = self.imgTick % 2;
        let st = pokemonImagesArr[result];
        let resultURL = URL(string: st);
        self.sprite.kf.setImage(with: resultURL);
        self.imgTick += 1
    }
    
    func getAbilityNames() {
        // AlamoFire runs validation on it's own side, so I do not need to concern myself with 200 response calls. .validate() does this for me.
        AF.request("https://pokeapi.co/api/v2/pokemon/\(pokemon.number)").validate().responseJSON { response in
            // Here's some json manipulation to get the ability names using the api above. These api's should probably be more decentralised and not in the VC.
            let json = JSON(response.value!);
            
            let jsonResult = JSON(json);
            let abilitiesJson = jsonResult["abilities"]
            
            // Hard coding is bad I know, in the interest of time I have done so. I intend to change this hard coded data in the future, get screen size, do some math etc.
            var yDecreases = 350
            //https://developer.apple.com/library/archive/documentation/General/Conceptual/Devpedia-CocoaApp/CoordinateSystem.html
            for (_, abilitiesJson):(String, JSON) in abilitiesJson {
                    
                let ability = abilitiesJson["ability"]["name"];
                self.abilityNames.append(ability.string!.capitalized);
                
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
                label.center = CGPoint(x: 320, y: yDecreases)
                label.textAlignment = .left
                label.text = ability.string!.capitalized;
                self.view.addSubview(label)
                yDecreases -= 30;
            }
        }
    }
}
