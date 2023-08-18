//
//  ReusableViewProtocol.swift
//  SeSAC3Week5
//
//  Created by 권현석 on 2023/08/17.
//

import UIKit

protocol ReusableProtocol {
    static var identifier: String { get }
}

extension UIViewController: ReusableProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView: ReusableProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }
}
