//
//  ViewController.swift
//  s10-pokedex
//
//  Created by Lukasz Grela on 20.09.2016.
//  Copyright © 2016 Commelius Solutions Ltd. All rights reserved.
//

import UIKit
import AVFoundation

let KEY_AUDIO_STATE = "audio-state"

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, XSearchBarDelegate {
    
    @IBOutlet weak var searchBar: XSearchBar!
    @IBOutlet weak var collection:UICollectionView!
    
    @IBOutlet weak var audioBtn: UIButton!
    
    var pokemons = [Pokemon]()
    var filteredPokemons = [Pokemon]()
    var isFiltered = false
    
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
            let audioPlaying = NSUserDefaults.standardUserDefaults().boolForKey(KEY_AUDIO_STATE)
            let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            musicPlayer.numberOfLoops = -1
            if audioPlaying {
                musicPlayer.play()
            }
            updateAudioBtn()
            
        } catch let err as NSError {
            print(err.debugDescription)
            audioBtn.setImage(UIImage(named: "mute"), forState: .Normal)
            audioBtn.enabled = false;
        }
    
    }
    func toggleAudio() {
        
        if musicPlayer.playing {
            musicPlayer.stop()
            audioBtn.setImage(UIImage(named: "mute"), forState: .Normal)
        } else {
            musicPlayer.play()
            audioBtn.setImage(UIImage(named: "audio"), forState: .Normal)
        }
        updateAudioBtn()
        //store setting
        NSUserDefaults.standardUserDefaults().setBool(musicPlayer.playing, forKey: KEY_AUDIO_STATE)
    }
    func updateAudioBtn(){
        if musicPlayer.playing {
            audioBtn.setImage(UIImage(named: "audio"), forState: .Normal)
        } else {
            audioBtn.setImage(UIImage(named: "mute"), forState: .Normal)
        }
    }
    @IBAction func audioButtonPressed(sender: UIButton) {
        toggleAudio()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("prepareForSegue \(sender)")
        if segue.identifier == "PokemonDetailVC" {
            print("segue.identifier \(segue.identifier)")
            if let vc = segue.destinationViewController as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    vc.pokemon = poke
                }
            }
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
        let list:[Pokemon] = isFiltered ? filteredPokemons:pokemons;
        
        let poke:Pokemon = list[indexPath.row]
        
        performSegueWithIdentifier("PokemonDetailVC", sender: poke)
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

