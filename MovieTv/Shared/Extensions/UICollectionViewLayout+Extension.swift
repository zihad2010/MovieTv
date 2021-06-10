//
//  UICollectionViewLayout+Extension.swift
//  MovieTv
//
//  Created by Asraful Alam on 10/6/21.
//

import Foundation
import UIKit

let itemSpaceing:CGFloat = UIDevice().userInterfaceIdiom == .phone ? 20.0 : 30.0
let numOfItems:CGFloat = UIDevice().userInterfaceIdiom == .phone ? 3 : 4

extension UICollectionViewLayout {
    
    static func customizedCollectionViewLayoutFor(_ collectionView: UICollectionView) -> UICollectionViewLayout {
        
        let width = (collectionView.bounds.width - (((numOfItems+1)) * itemSpaceing))/numOfItems
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: itemSpaceing, left: itemSpaceing, bottom: 0, right: itemSpaceing)
        layout.itemSize = CGSize(width: width, height:  width)
        layout.minimumLineSpacing = itemSpaceing
        return layout
    }
}
