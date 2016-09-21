//
//  PokeCell.swift
//  pokedexgo
//
//  Created by Michael Dunn on 2016-09-21.
//  Copyright © 2016 Michael Dunn. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon:Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
        layer.backgroundColor = UIColor.white.withAlphaComponent(0.5).cgColor
    }
    
    func configureCell(_ pokemon: Pokemon){
        self.pokemon = pokemon
        
        nameLabel.text = self.pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(self.pokemon.id)")
        
    }
    
}
