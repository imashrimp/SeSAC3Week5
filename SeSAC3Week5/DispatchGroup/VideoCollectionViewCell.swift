//
//  VideoCollectionViewCell.swift
//  SeSAC3Week5
//
//  Created by 권현석 on 2023/08/19.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var videoNumberLabel: UILabel!
    @IBOutlet var videoTitleLabel: UILabel!
    @IBOutlet var siteAndLinkLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        videoNumberLabel.font = .boldSystemFont(ofSize: 15)
        videoTitleLabel.textAlignment = .left
        
        videoTitleLabel.font = .boldSystemFont(ofSize: 15)
        videoTitleLabel.textAlignment = .left
        videoTitleLabel.numberOfLines = 0
        
        siteAndLinkLabel.font = .systemFont(ofSize: 13)
        siteAndLinkLabel.textAlignment = .left
        siteAndLinkLabel.numberOfLines = 0
    }
    
    func showCellContents(data: VideoInfo) {
        
        videoTitleLabel.text = "제목: \(data.name)"
        siteAndLinkLabel.text = "\(data.site): https://www.youtube.com/watch?\(data.key)"
    }

}
