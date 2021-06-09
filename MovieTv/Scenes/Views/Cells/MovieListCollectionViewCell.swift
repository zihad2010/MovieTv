//
//  MovieListCollectionViewCell.swift
//  MovieTv
//
//  Created by Asraful Alam on 10/6/21.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
   
    public var eachMovie: MovieViewModel! {
        didSet {
            self.movieTitle.text = eachMovie.title
           
        }
    }
    
}
