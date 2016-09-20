//
//  ViewController.swift
//  s10-pokedex
//
//  Created by Lukasz Grela on 20.09.2016.
//  Copyright © 2016 Commelius Solutions Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collection:UICollectionView!
    
    
    var pokemons = [Pokemon]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1...30 {
            pokemons.append(Pokemon(name: "poke-\(i)", id: i))
        }
        
        collection.delegate = self
        collection.dataSource = self
    }


    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //
        var cell:PokeCell
        if let _cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell {
            cell = _cell
        
        } else {
            cell = PokeCell()
        }
        
        
        cell.configureCell(pokemons[indexPath.row])
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //
        return pokemons.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
}

