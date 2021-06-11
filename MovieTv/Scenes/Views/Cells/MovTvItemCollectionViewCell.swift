//
//  MovTvItemCollectionViewCell.swift
//  MovieTv
//
//  Created by Asraful Alam on 10/6/21.
//

import UIKit

class MovTvItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

     public var eachMovie: EachItemViewModel! {
         didSet {
             self.movieTitle.text = eachMovie.title
             guard let url = eachMovie.posterURL else {
                 return
             }
             posterImage.getImage(url: url, placeholderImage: UIImage(named: "placeholder")) { (success) in
             } failer: { [weak self] (faield) in
                 self?.posterImage.image = UIImage(named: "placeholder")
             }
         }
     }

}