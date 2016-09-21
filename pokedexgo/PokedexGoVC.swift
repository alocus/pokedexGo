//
//  PokedexGpVC.swift
//  pokedexgo
//
//  Created by Michael Dunn on 2016-09-20.
//  Copyright © 2016 Michael Dunn. All rights reserved.
//

import UIKit
import AVFoundation

class PokedexGoVC : UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemons: [Pokemon] = []
    var musicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collection.dataSource = self
        self.collection.delegate = self
   
        self.searchBar.delegate = self
        
        parsePokemonCSV()
        initAudio()
    }
    
    func initAudio(){
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")
            
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path!)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    
    func parsePokemonCSV(){
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            
            print(rows)
            
            for row in rows {
                let id = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let pokemon = Pokemon(id: id, name: name)
                pokemons.append(pokemon)
            }
            
        } catch let error as NSError{
            print(error.debugDescription)
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // step 1 - dequeue a reusable cell
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell{
            
            let pokemon = pokemons[indexPath.row]
            cell.configureCell(pokemon)
            
            return cell
        }else {
            return UICollectionViewCell()
        }
    }
    
    // execute when cell is tapped
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    
   // touch anywhere to remove keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    // turn on/off music and dim the button when off.
    @IBAction func musicButtonPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying {
            musicPlayer.stop()
            sender.alpha = 0.5
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }

    }
}

