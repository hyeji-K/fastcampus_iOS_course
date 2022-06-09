//
//  ListCell.swift
//  SSCollection
//
//  Created by heyji on 2022/06/04.
//

import UIKit

class ListCell: UICollectionViewCell {
    
    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var appDescriptionLabel: UILabel!
    
    func configure(_ list: Contents) {
        
//        if let url = URL(string: list.appImage) {
//            do {
//                let data = try Data(contentsOf: url)
//                DispatchQueue.main.async {
//                    self.appImageView.image = UIImage(data: data)
//                }
//            } catch {
//                print("appImage download failed")
//            }
//        }
        appImageView.image = UIImage(named: list.appImage)
        appNameLabel.text = list.appName
        appDescriptionLabel.text = list.appDescription
    }
}
