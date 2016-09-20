//
//  XLabel.swift
//  s10-pokedex
//
//  Created by Lukasz Grela on 20.09.2016.
//  Copyright © 2016 Commelius Solutions Ltd. All rights reserved.
//

import UIKit

class XLabel: UILabel {

    private var _topInset = CGFloat(5.0)
    private var _bottomInset = CGFloat(5.0)
    private var _leftInset = CGFloat(8.0)
    private var _rightInset = CGFloat(8.0)
    
    override func drawTextInRect(rect: CGRect) {
        
        let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
        
    }
    override func intrinsicContentSize() -> CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize()
        intrinsicSuperViewContentSize.height += topInset + bottomInset
        intrinsicSuperViewContentSize.width += leftInset + rightInset
        return intrinsicSuperViewContentSize
    }

    var topInset:CGFloat {
        get {
            return _topInset
        }
        set {
            
            _topInset = newValue
            
            self.setNeedsLayout()
        }
    }
    var bottomInset:CGFloat {
        get {
            return _bottomInset
        }
        set {
            
            _bottomInset = newValue
            
            self.setNeedsLayout()
        }
    }
    var leftInset:CGFloat {
        get {
            return _leftInset
        }
        set {
            
            _leftInset = newValue
            
            self.setNeedsLayout()
        }
    }
    var rightInset:CGFloat {
        get {
            return _rightInset
        }
        set {
            
            _rightInset = newValue
            
            self.setNeedsLayout()
        }
    }
    
}
