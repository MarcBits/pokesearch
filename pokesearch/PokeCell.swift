//
//  PokeCell.swift
//  pokesearch
//
//  Created by Marc Cruz on 12/26/16.
//  Copyright © 2016 MarcBits. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    // MARK: outlets
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(_ pokemon: Pokemon) {
        
        self.pokemon = pokemon
        nameLabel.text = self.pokemon.name.capitalized
        thumbImage.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
    
}
