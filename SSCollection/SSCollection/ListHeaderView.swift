//
//  ListHeaderView.swift
//  SSCollection
//
//  Created by heyji on 2022/06/04.
//

import UIKit

class ListHeaderView: UICollectionReusableView {
        
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(_ title: String) {
        titleLabel.text = title
    }
}
