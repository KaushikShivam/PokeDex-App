//
//  PokemonDetailVC.swift
//  PokeDex App
//
//  Created by shivam kaushik on 13/02/16.
//  Copyright © 2016 shivam kaushik. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

  var pokemon: Pokemon!
  

  @IBOutlet weak var nameLbl: UILabel!
  @IBOutlet weak var mainImg: UIImageView!
  @IBOutlet weak var descriptionLbl: UILabel!
  @IBOutlet weak var typeLbl: UILabel!
  @IBOutlet weak var defenceLbl: UILabel!
  @IBOutlet weak var heightLbl: UILabel!
  @IBOutlet weak var pokedexLbl: UILabel!
  @IBOutlet weak var weightLbl: UILabel!
  @IBOutlet weak var baseAttackLbl: UILabel!
  @IBOutlet weak var currentEvoLbl: UIImageView!
  @IBOutlet weak var nextEvoLbl: UIImageView!
  @IBOutlet weak var evoLbl: UILabel!
  
  @IBAction func backButtonPressed(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    nameLbl.text = pokemon.name
    mainImg.image = UIImage(named: "\(pokemon.pokedexId)")
    currentEvoLbl.image = UIImage(named: "\(pokemon.pokedexId)")
    
    pokemon.downloadPokemonDetails { () -> () in
      self.updateUI()
    }
  }
  
  func updateUI() {
    descriptionLbl.text = pokemon.description
    typeLbl.text = pokemon.type
    defenceLbl.text = pokemon.defense
    heightLbl.text = pokemon.height
    pokedexLbl.text = "\(pokemon.pokedexId)"
    weightLbl.text = pokemon.weight
    baseAttackLbl.text = pokemon.attack
    
    if pokemon.nextEvolutionId == "" {
      evoLbl.text = "No evolutions"
      nextEvoLbl.hidden = true
    } else {
      nextEvoLbl.hidden = false
      nextEvoLbl.image = UIImage(named: pokemon.nextEvolutionId)
      var str = "Next Evolution: \(pokemon.nextEvolutionTxt)"
      
      if pokemon.nextEvolutionLvl != "" {
        str += " - LVL \(pokemon.nextEvolutionLvl)"
      }
      evoLbl.text = str
    }
    
    
  }
  
  
  
  
  
  
  
  
  
  
  
}
