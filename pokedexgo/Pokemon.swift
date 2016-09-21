//
//  Pokemon.swift
//  pokedexgo
//
//  Created by Michael Dunn on 2016-09-20.
//  Copyright © 2016 Michael Dunn. All rights reserved.
//

import Foundation

class Pokemon{
    
    fileprivate var _id: Int!
    fileprivate var _name: String!
    
    var name: String{
        return _name
    }
    
    var id: Int{
        return _id
    }
    
    init(id :Int, name: String){
        _id = id
        _name = name
    }
}
