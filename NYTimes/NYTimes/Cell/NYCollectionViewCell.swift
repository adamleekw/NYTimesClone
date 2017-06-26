//
//  NYCollectionViewCell.swift
//  NYTimes
//
//  Created by Adam on 25/6/17.
//  Copyright © 2017 MDT002MBP. All rights reserved.
//

import UIKit

class NYCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSnippet: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet var toImgTrail: NSLayoutConstraint!
    @IBOutlet var toTrail: NSLayoutConstraint!
    //forces the system to do one layout pass
    var isHeightCalculated: Bool = false
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        //Exhibit A - We need to cache our calculation to prevent a crash.
        if !isHeightCalculated {
            setNeedsLayout()
            layoutIfNeeded()
            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
            var newFrame = layoutAttributes.frame
            newFrame.size.width = CGFloat(ceilf(Float(size.width)))
            layoutAttributes.frame = newFrame
            isHeightCalculated = true
        }
        return layoutAttributes
    }
}

