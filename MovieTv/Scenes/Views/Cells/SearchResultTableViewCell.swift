//
//  SearchResultTableViewCell.swift
//  MovieTv
//
//  Created by Asraful Alam on 11/6/21.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var  posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptonLabel: UILabel!
    
    public var eachMovie: SearchResultCellVM! {
        didSet {
            self.titleLabel.text = eachMovie.title
            self.descriptonLabel.text = eachMovie.overview
            guard let url = eachMovie.posterURL else {
                return
            }
            posterImageView.getImage(url: url, placeholderImage: UIImage(named: "placeholder")) { (success) in
            } failer: { [weak self] (faield) in
                self?.posterImageView.image = UIImage(named: "placeholder")
            }
        }
    }
    
}
