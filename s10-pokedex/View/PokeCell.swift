//
//  PokeCell.swift
//  s10-pokedex
//
//  Created by Lukasz Grela on 20.09.2016.
//  Copyright © 2016 Commelius Solutions Ltd. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg:UIImageView!
    @IBOutlet weak var nameLbl:UILabel!
    
    var pokemon:Pokemon!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        
    }
    
    
    func configureCell(pokemon:Pokemon) {
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalizedString
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
    

}
