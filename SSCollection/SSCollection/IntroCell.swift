//
//  IntroCell.swift
//  SSCollection
//
//  Created by heyji on 2022/06/04.
//

import UIKit

class IntroCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var appDescriptionLabel: UILabel!
    
 
    override func awakeFromNib() {
        super.awakeFromNib()
//        roundView.cornerRadius = 10
        bottomView.backgroundColor = .gray
        
    }
    
    
    func configure(_ intro: Intro) {
        titleLabel.text = intro.title
        nameLabel.text = intro.name
        descriptionLabel.text = intro.description
        thumbnailImageView.image = UIImage(named: intro.thumbnailImageName)
        
        let url = URL(string: intro.appName)
        
        if let data = try? Data(contentsOf: url!) {
            DispatchQueue.main.async {
                self.appImageView.image = UIImage(data: data)
            }
            
        }
        
        appNameLabel.text = intro.appName
        appDescriptionLabel.text = intro.appDescription
        
    }
}
