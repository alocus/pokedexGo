//
//  Pokemon.swift
//  pokedexgo
//
//  Created by Michael Dunn on 2016-09-20.
//  Copyright © 2016 Michael Dunn. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon{
    
    private var _id: Int!
    private var _name: String!
    
    private var _description:String!
    private var _defense: String!
    private var _type: String!
    private var _attack: String!
    private var _height: String!
    private var _weight: String!
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    private var _pokemonURL: String!
    
    
    var nextEvoLevel :String{
        return _nextEvolutionLevel ?? ""
    }
    
    var nextEvolutionLevel: String {
        if _nextEvolutionLevel == nil {
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
    
    var nextEvolutionId: String {
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nex: String {
        if _nextEvolutionTxt == nil {
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    var name: String{
        return _name
    }
    
    var id: Int{
        return _id
    }
    
    init(id :Int, name: String){
        self._id = id
        self._name = name
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON_V1)\(self.id)/"
    }
    
    func downloadPokemonDetail(completed: @escaping DownloadCompleted) {
        
        let url = URL(string: self._pokemonURL)!
        
        print("DEBUG \(url)")
        Alamofire.request(
            url
            ).responseJSON { response in
                
                //print("RESULT  \(response.result.value)")
                if let dict = response.result.value as? Dictionary<String, AnyObject>{
                    if let weight = dict["weight"] as? String{
                        self._weight = weight
                    }
                    
                    if let height = dict["height"] as? String{
                        self._height = height
                    }
                    
                    if let attack = dict["attack"] as? Int {
                        
                        self._attack = "\(attack)"
                    }
                    
                    if let defense = dict["defense"] as? Int {
                        
                        self._defense = "\(defense)"
                    }
                    
//                    print(self._weight)
//                    print(self._height)
//                    print(self._attack)
//                    print(self._defense)
                    if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                        if let name = types[0]["name"] {
                            self._type = name.capitalized
                        }
                        
                        if types.count > 1 {
                            for x in 1..<types.count {
                                if let name = types[x]["name"] {
                                    self._type! += "/\(name.capitalized)"
                                }
                            }
                        }
                        
                    } else {
                        self._type = ""
                    }

                    
                    if let descArr = dict["descriptions"] as? [Dictionary<String, String>] , descArr.count > 0 {
                        
                        if let url = descArr[0]["resource_uri"] {
                            
                            let descURL = URL(string: "\(URL_BASE)\(url)")!
                            
                            Alamofire.request(descURL
                                ).responseJSON(completionHandler: { (response) in
                                
                                if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                    
                                    if let description = descDict["description"] as? String {
                                        
                                        let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                        
                                        self._description = newDescription
                                        print(newDescription)
                                    }
                                }
                                
                                completed()
                            })
                        }
                    } else {
                        
                        self._description = ""
                    }

                    
                    if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] , evolutions.count > 0 {
                        
                        if let nextEvo = evolutions[0]["to"] as? String {
                            
                            if nextEvo.range(of: "mega") == nil {
                                
                                self._nextEvolutionName = nextEvo
                                
                                if let uri = evolutions[0]["resource_uri"] as? String {
                                    
                                    let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                    let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
                                    
                                    self._nextEvolutionId = nextEvoId
                                    
                                    if let lvlExist = evolutions[0]["level"] {
                                        
                                        if let lvl = lvlExist as? Int {
                                            
                                            self._nextEvolutionLevel = "\(lvl)"
                                        }
                                        
                                    } else {
                                        
                                        self._nextEvolutionLevel = ""
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                        print(self.nextEvolutionLevel)
                        print(self.nextEvolutionName)
                        print(self.nextEvolutionId)
                    }
                
                }
                
             completed()
        } // responseJSON
        
    }
}
