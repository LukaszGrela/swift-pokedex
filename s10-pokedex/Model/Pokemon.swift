//
//  Pokemon.swift
//  s10-pokedex
//
//  Created by Lukasz Grela on 20.09.2016.
//  Copyright © 2016 Commelius Solutions Ltd. All rights reserved.
//

import Foundation

class Pokemon: CustomStringConvertible {
    
    private var _name:String!
    private var _pokedexId:Int!
    
    private var _data:Dictionary<String, String>?
    
    init(name:String, id:Int) {
        _name = name
        _pokedexId = id
    }
    
    
    convenience init(data:Dictionary<String, String>) {
        let pokeId = Int(data["id"]!)!
        let name = data["identifier"]!
        self.init(name: name, id:pokeId)
        self._data = data
    }
    
    
    var name:String {
        return _name
    }
    
    var pokedexId:Int {
        return _pokedexId
    }
    
    
    var description: String {
        return "Pokemon, name=\(self.name), pokedexId=\(self.pokedexId)"
    }
}