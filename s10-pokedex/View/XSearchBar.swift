//
//  XSearchBar.swift
//  s10-pokedex
//
//  Created by Lukasz Grela on 20.09.2016.
//  Copyright © 2016 Commelius Solutions Ltd. All rights reserved.
//

import UIKit

@objc public protocol XSearchBarDelegate:UISearchBarDelegate {
    
    /// Asks the delegate if the searchbar's text field’s current contents should be removed.
    /// true if the text field’s contents should be cleared; otherwise, false.
    optional func searchBarShouldClear(searchBar: UISearchBar) -> Bool;
}

class XSearchBar: UISearchBar, UITextFieldDelegate {

    
    override func didAddSubview(subview: UIView) {
        super.didAddSubview(subview)
        //if subview is UITextField
        if(subview is UITextField) {
            let tf:UITextField = subview as! UITextField
                tf.delegate = self
        }
    }
    
    
    //MARK:UITextFieldDelegate
    func textFieldShouldClear(textField: UITextField) -> Bool {
        
        if self.delegate?.respondsToSelector(#selector(XSearchBarDelegate.searchBarShouldClear(_:))) ?? true {
            if let xDelegate = self.delegate as? XSearchBarDelegate {
                let shouldClear = xDelegate.searchBarShouldClear!(self)
                
                return shouldClear
            }
        }
        //allow by default
        return true;
    }
}
