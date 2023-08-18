//
//  SimiliarMovieCollectionViewCell.swift
//  SeSAC3Week5
//
//  Created by 권현석 on 2023/08/18.
//

import UIKit
import Kingfisher

class SimiliarMovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieTitleLabel.font = .boldSystemFont(ofSize: 15)
        movieTitleLabel.textAlignment = .left
        
        releaseDateLabel.font = .systemFont(ofSize: 14)
        releaseDateLabel.textAlignment = .left
        
    }
    
    func showCellContents(data: SimilarFilms) {
        movieTitleLabel.text = data.title
        releaseDateLabel.text = data.releaseDate
        
        guard let posterUrl = data.posterPath else {
            posterImageView.image = UIImage(systemName: "popcorn.fill")
            return
        }
        
        guard let imageURL = URL(string: ImageUrl.head + posterUrl) else { return }
        posterImageView.kf.setImage(with: imageURL)
    }

}
