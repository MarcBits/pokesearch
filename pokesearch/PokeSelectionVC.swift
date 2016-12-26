//
//  PokeSelectionVC.swift
//  pokesearch
//
//  Created by Marc Cruz on 12/24/16.
//  Copyright © 2016 MarcBits. All rights reserved.
//

import UIKit

protocol PokeSelectionVCDelegate: class {
    func pokeSelectionVC(controller: PokeSelectionVC, didSelectPokemon selectedPoke: Pokemon)
}

class PokeSelectionVC: UIViewController, UICollectionViewDelegate,
                       UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,
                       UISearchBarDelegate {

    weak var delegate: PokeSelectionVCDelegate?
    
    // MARK: outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collection: UICollectionView!
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        
        parsePokemonCSV()
    }
    
    func parsePokemonCSV() {
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let poke = Pokemon(name: name, pokedexId: pokeId)
                pokemon.append(poke)
            }
            
        } catch let err as NSError {
            
            print(err.description)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let poke: Pokemon!
            
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            
            return filteredPokemon.count
        }
        
        return pokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 105, height: 105)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true)
        } else {
            
            inSearchMode = true
            let lower = searchBar.text!.lowercased()
            filteredPokemon = pokemon.filter({$0.name.range(of: lower) != nil})
            collection.reloadData()
        }
    }
}

// MARK: extensions
extension PokeSelectionVC {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var poke: Pokemon!

        if inSearchMode {

            poke = filteredPokemon[indexPath.row]
            
        } else {

            poke = pokemon[indexPath.row]
        }
        
        // In the pokedex3 project a navigation back was implemented via "performSegue"
        delegate?.pokeSelectionVC(controller: self, didSelectPokemon: poke)
    }
}
