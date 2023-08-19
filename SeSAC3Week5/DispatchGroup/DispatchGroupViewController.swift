//
//  DispatchGroupViewController.swift
//  SeSAC3Week5
//
//  Created by 권현석 on 2023/08/18.
//

//MARK: - prefetch랑 pagenation 써보자

import UIKit

class DispatchGroupViewController: UIViewController {
    
    var movieList: SimilarMovie?
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureCollectionViewLayout()
        
        callRequest()
    }
    
    func callRequest() {
        TMDBManager.shared.callRequestSimilarMovie(movieID: 150689) { movie in
            self.movieList = movie
            self.collectionView.reloadSections([0])
        }
    }
}

extension DispatchGroupViewController: UICollectionViewDelegate {
    
}

extension DispatchGroupViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList?.similar.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimiliarMovieCollectionViewCell.identifier, for: indexPath) as? SimiliarMovieCollectionViewCell else { return SimiliarMovieCollectionViewCell() }
        
        guard let movieData = movieList else { return SimiliarMovieCollectionViewCell() }
        
        let item = movieData.similar.results
        
        cell.showCellContents(data: item[indexPath.row])
        print("=====")
        print(indexPath)
        print("=====")
        
        return cell
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            guard
                let view =
                    collectionView.dequeueReusableSupplementaryView(
                        ofKind: kind,
                        withReuseIdentifier:
                            SimilarMovieCollectionReusableView.identifier,
                        for: indexPath
                    ) as? SimilarMovieCollectionReusableView
            else { return UICollectionReusableView() }

            guard let movie = movieList else {
                
                view.isHidden = true
                
                return view }
            
            view.showContentsOnView(data: movie)
            return view
            
        } else {
            fatalError()
//            return UICollectionReusableView()
        }
    }
    
}

extension DispatchGroupViewController: CollectionViewAttributeProtocol {
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let cellNib = UINib(nibName: SimiliarMovieCollectionViewCell.identifier, bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: SimiliarMovieCollectionViewCell.identifier)
        
        collectionView.register(UINib(nibName: SimilarMovieCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SimilarMovieCollectionReusableView.identifier)
    }
    
    func configureCollectionViewLayout() {
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = (UIScreen.main.bounds.width - ( 20 * 3)) / 2
        
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.scrollDirection = .vertical
        
        //MARK: - 여기다 헤더 추가해야함.
        layout.headerReferenceSize = CGSize(width: 300, height: 150)
        
        collectionView.collectionViewLayout = layout
    }
    
    
}
