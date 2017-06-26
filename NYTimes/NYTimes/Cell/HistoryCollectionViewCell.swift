//
//  HistoryCollectionViewCell.swift
//  NYTimes
//
//  Created by Adam on 25/6/17.
//  Copyright © 2017 MDT002MBP. All rights reserved.
//

import UIKit

class HistoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblText: UILabel!

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

