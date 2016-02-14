//
//  PokeCell.swift
//  PokeDex App
//
//  Created by shivam kaushik on 13/02/16.
//  Copyright © 2016 shivam kaushik. All rights reserved.
//


import UIKit

class PokeCell: UICollectionViewCell {

  @IBOutlet weak var thumbImg: UIImageView!
  @IBOutlet weak var nameLbl: UILabel!
  
  var pokemon: Pokemon!
  
  func configureCell(pokemon: Pokemon) {
    self.pokemon = pokemon
    nameLbl.text = self.pokemon.name.capitalizedString
    thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    self.layer.cornerRadius = 5.0
    
  }
  
  
}
