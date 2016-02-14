//
//  ViewController.swift
//  PokeDex App
//
//  Created by shivam kaushik on 13/02/16.
//  Copyright © 2016 shivam kaushik. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet var searchBar: UISearchBar!
  
  var pokemon: [Pokemon] = [Pokemon]()
  
  var musicPlayer: AVAudioPlayer!
  var inSearchMode = false
  var filteredPokemon = [Pokemon]()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    collectionView.delegate = self
    collectionView.dataSource = self
    searchBar.delegate = self
    searchBar.returnKeyType = UIReturnKeyType.Done
    initAudio()
    parsePokemonCsv()
  }
  
  func initAudio() {
    let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!

    do {
      musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: path))
      musicPlayer.prepareToPlay()
      musicPlayer.numberOfLoops = -1
      musicPlayer.play()
    } catch let error as NSError {
      print(error.debugDescription)
    }
    
  }
  
  func parsePokemonCsv() {
    let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
    
    do {
      let csv = try CSV(contentsOfURL: path)
      let rows = csv.rows
      
      for row in rows {
        let pokeID = Int(row["id"]!)!
        let name = row["identifier"]!
        let poke = Pokemon(name: name, pokedexId: pokeID)
        pokemon.append(poke)
      }
      
    } catch let error as NSError {
      print(error.debugDescription)
    }
    
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if inSearchMode {
      return filteredPokemon.count
    } else {
      return pokemon.count
    }
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell {
      
      var poke: Pokemon!
      if inSearchMode {
        poke = filteredPokemon[indexPath.row]
      } else {
        poke = pokemon[indexPath.row]
      }
      cell.configureCell(poke)

      return cell
    } else {
      return UICollectionViewCell()
    }
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
    var poke: Pokemon!
    if inSearchMode {
      poke = filteredPokemon[indexPath.row]
    } else {
      poke = pokemon[indexPath.row]
    }
    
    performSegueWithIdentifier("PokemonDetailVC", sender: poke)
    
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "PokemonDetailVC" {
      if let controller = segue.destinationViewController as? PokemonDetailVC {
        if let poke = sender as? Pokemon {
          controller.pokemon = poke
        }
      }
    }
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    
    return CGSizeMake(105, 105)
    
  }
  
  
  
  @IBAction func musicButtonPressed(sender: UIButton) {
    if musicPlayer.playing {
      musicPlayer.stop()
      sender.alpha = 0.2
    } else {
      musicPlayer.play()
      sender.alpha = 1.0
    }
  }
  
  func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    if searchBar.text == nil || searchBar.text == "" {
      inSearchMode = false
      view.endEditing(true)
      collectionView.reloadData()
    } else {
      inSearchMode = true
      let lower = searchBar.text!.lowercaseString
      filteredPokemon = pokemon.filter({$0.name.rangeOfString(lower) != nil})
      collectionView.reloadData()
    }
  }
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
  }
 
}










