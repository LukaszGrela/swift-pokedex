//
//  ViewController.swift
//  s10-pokedex
//
//  Created by Lukasz Grela on 20.09.2016.
//  Copyright © 2016 Commelius Solutions Ltd. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, XSearchBarDelegate {
    
    @IBOutlet weak var searchBar: XSearchBar!
    @IBOutlet weak var collection:UICollectionView!
    
    @IBOutlet weak var audioBtn: UIButton!
    
    var pokemons = [Pokemon]()
    var filteredPokemons = [Pokemon]()
    var isFiltered = false
    
    var audioPlaying = true
    var musicPlayer: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
        
        
        collection.delegate = self
        collection.dataSource = self
        initAudio()
        parsePokemonCSV()
    }


    func parsePokemonCSV() {
        
        //for i in 1...718 {
        //    pokemons.append(Pokemon(name: "pokemon name-\(i)", id: i))
        //}
        
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                pokemons.append(Pokemon(data: row))
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    func initAudio(){
        do {
            let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
        } catch let err as NSError {
            print(err.debugDescription)
            audioBtn.setImage(UIImage(named: "mute"), forState: .Normal)
            audioBtn.enabled = false;
        }
    
    }
    @IBAction func audioButtonPressed(sender: UIButton) {
        if musicPlayer.playing {
            musicPlayer.stop()
            sender.setImage(UIImage(named: "mute"), forState: .Normal)
        } else {
            musicPlayer.play()
            sender.setImage(UIImage(named: "audio"), forState: .Normal)
        }
    }
    
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //
        var cell:PokeCell
        if let _cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell {
            cell = _cell
        
        } else {
            cell = PokeCell()
        }
        
        
        var list:[Pokemon] = isFiltered ? filteredPokemons:pokemons;
        
        cell.configureCell(list[indexPath.row])
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //
        let list:[Pokemon] = isFiltered ? filteredPokemons:pokemons;
        //
        return list.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    // MARK: UISearchBarDelegate
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil ||  (searchBar.text?.isEmpty)! {
            isFiltered = false
            
        } else {
            isFiltered = true
            let term = searchBar.text!.lowercaseString
            
            filteredPokemons = pokemons.filter({ (poke:Pokemon) -> Bool in
                //
             return poke.name.rangeOfString(term) != nil
            })
 
            //filteredPokemons = pokemons.filter({$0.name.rangeOfString(term) != nil})
        }
        collection.reloadData()
    }
    
    
    func searchBarShouldClear(searchBar: UISearchBar) -> Bool {
        
        performSelector(#selector(ViewController.hideKeyboardWithSearchBar), withObject: nil, afterDelay: 0)
        
        return true
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    func hideKeyboardWithSearchBar() {
        searchBar.resignFirstResponder()
        view.endEditing(true)
    }
}

