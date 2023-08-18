//
//  DispatchGroupViewController.swift
//  SeSAC3Week5
//
//  Created by 권현석 on 2023/08/18.
//

import UIKit

class DispatchGroupViewController: UIViewController {

    
    @IBOutlet var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TMDBManager.shared.callRequestSimilarMovie(movieID: 150689) { movie in
            print("호출됨")
        }
    }


}
