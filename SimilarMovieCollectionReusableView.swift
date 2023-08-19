//
//  SimilarMovieCollectionReusableView.swift
//  SeSAC3Week5
//
//  Created by 권현석 on 2023/08/19.
//

import UIKit
import Kingfisher

class SimilarMovieCollectionReusableView: UICollectionReusableView {

    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var backPosterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        movieTitleLabel.font = .boldSystemFont(ofSize: 15)
        movieTitleLabel.textAlignment = .center
        movieTitleLabel.textColor = .white
        
        backPosterImageView.contentMode = .scaleAspectFill
        
    }
    
    func showContentsOnView(data: SimilarMovie) {
        
        movieTitleLabel.text = data.title
        
        guard let imageUrl = URL(string: ImageUrl.head + data.backdropPath) else { return }
        backPosterImageView.kf.setImage(with: imageUrl)
    }
    
}
