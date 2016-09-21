//
//  PokemonDetailVC.swift
//  pokedexgo
//
//  Created by Michael Dunn on 2016-09-21.
//  Copyright © 2016 Michael Dunn. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = pokemon.name
        
    }
}
