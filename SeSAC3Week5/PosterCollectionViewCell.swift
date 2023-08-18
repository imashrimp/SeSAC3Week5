//
//  PosterCollectionViewCell.swift
//  SeSAC3Week5
//
//  Created by 권현석 on 2023/08/16.
//

import UIKit

class PosterCollectionViewCell: UICollectionViewCell {

    @IBOutlet var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    //셀 재사용 시 이전 사용 흔적 지우기 위해 사용
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.image = nil
    }

}
