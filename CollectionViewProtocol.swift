//
//  CollectionViewProtocol.swift
//  SeSAC3Week5
//
//  Created by 권현석 on 2023/08/18.
//

import Foundation
@objc
protocol CollectionViewAttributeProtocol {
    func configureCollectionView()
    @objc optional func configureCollectionViewLayout()
}
