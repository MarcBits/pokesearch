//
//  PokeAnnotation.swift
//  pokesearch
//
//  Created by Marc Cruz on 12/23/16.
//  Copyright © 2016 MarcBits. All rights reserved.
//

import Foundation
import MapKit

class PokeAnnotation: NSObject, MKAnnotation {
    var pokemon = [Pokemon]()
    
    var coordinate = CLLocationCoordinate2D()
    var pokemonNumber: Int
    var pokemonName: String
    var title: String?
    
    init(coordinate: CLLocationCoordinate2D, pokemonNumber: Int) {
        
        self.coordinate = coordinate
        self.pokemonNumber = pokemonNumber
        
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
        
        // pokemon array is zero-based, so subtract one from the actual id to get the name
        self.pokemonName =  (pokemon[pokemonNumber - 1] as Pokemon).name.capitalized
        self.title = self.pokemonName
    }
}
