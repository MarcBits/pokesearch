//
//  Pokemon.swift
//  pokesearch
//
//  Created by Marc Cruz on 12/26/16.
//  Copyright © 2016 MarcBits. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    
    var name: String {
        if _name == nil {
            
            _name = ""
        }
        return _name
    }
    
    var pokedexId: Int {
        if _pokedexId == nil {
            
            _pokedexId = 0
        }
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        
        self._name = name
        self._pokedexId = pokedexId        
    }
}
