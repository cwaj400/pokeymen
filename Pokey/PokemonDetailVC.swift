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

class PokemonDetailVC: UIViewController {

    @IBOutlet weak var name: UILabel!
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.name.text = ""
        print("in pokemon details")
        //blah
    }
    
}
