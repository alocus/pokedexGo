//
//  Pokemon.swift
//  pokedexgo
//
//  Created by Michael Dunn on 2016-09-20.
//  Copyright © 2016 Michael Dunn. All rights reserved.
//

import Foundation

class Pokemon{
    
    private var _id: Int!
    private var _name: String!
    
    private var _description:String!
    private var _defense: String!
    private var _type: String!
    private var _attack: String!
    private var _height: String!
    private var _weight: String!
    private var _evolveMessage: String!
    private var _currentStateId: String!
    private var _evolvedStateId: String!
    
    
    
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
