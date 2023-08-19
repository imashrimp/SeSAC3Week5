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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.contentMode = .scaleAspectFit
        
        movieTitleLabel.font = .boldSystemFont(ofSize: 15)
        movieTitleLabel.textAlignment = .left
        movieTitleLabel.numberOfLines = 0
        
        self.layer.cornerRadius = 8
        self.backgroundColor = UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
        
    }
    
    func showCellContents(data: SimilarFilms) {
        movieTitleLabel.text = "제목: \(data.title)"
        guard let posterUrl = data.posterPath else {
            posterImageView.image = UIImage(systemName: "popcorn.fill")
            return
        }
        
        guard let imageURL = URL(string: ImageUrl.head + posterUrl) else { return }
        posterImageView.kf.setImage(with: imageURL)
    }

}
