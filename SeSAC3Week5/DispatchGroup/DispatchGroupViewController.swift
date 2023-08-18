//
//  DispatchGroupViewController.swift
//  SeSAC3Week5
//
//  Created by 권현석 on 2023/08/18.
//

import UIKit

class DispatchGroupViewController: UIViewController {

    var movie: SimilarMovie?
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureCollectionViewLayout()
        
        TMDBManager.shared.callRequestSimilarMovie(movieID: 150689) { movie in
            self.movie = movie
        }
    }
}

extension DispatchGroupViewController: UICollectionViewDelegate {
    
}

extension DispatchGroupViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie?.similar.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimiliarMovieCollectionViewCell.identifier, for: indexPath)
        
        
        return cell
        
    }
}

extension DispatchGroupViewController: CollectionViewAttributeProtocol {
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let cellNib = UINib(nibName: SimiliarMovieCollectionViewCell.identifier, bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: SimiliarMovieCollectionViewCell.identifier)
    }
    
    func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 250)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        layout.scrollDirection = .vertical
        
        //MARK: - 여기다 헤더 추가해야함.
        
        collectionView.collectionViewLayout = layout
    }
    
    
}
