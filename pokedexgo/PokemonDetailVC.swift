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
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nextEvolutionLabel: UILabel!
    @IBOutlet weak var currState: UIImageView!
    @IBOutlet weak var evolvedState: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = pokemon.name.capitalized
        
        let img = UIImage(named: "\(pokemon.id)")
        
        imageView.image = img
        currState.image = img
        idLabel.text = "\(pokemon.id)"
        typeLabel.text = pokemon.type
        
        
        pokemon.downloadPokemonDetail(){
                self.updateUI()
        }
        
    }
    
    func updateUI(){
     
        attackLabel.text = pokemon.attack
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        typeLabel.text = pokemon.type
        descriptionLabel.text = pokemon.description
        
        if pokemon.nextEvolutionId == "" {
            nextEvolutionLabel.text = "No Evolutions"
            evolvedState.isHidden = true
            
        } else {
            
            evolvedState.isHidden = false
            evolvedState.image = UIImage(named: pokemon.nextEvolutionId)
            let str = "Next Evolution: \(pokemon.nextEvolutionName) - LVL \(pokemon.nextEvolutionLevel)"
            nextEvolutionLabel.text = str
        }

    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
