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
        roundView.layer.cornerRadius = 5
        thumbnailImageView.layer.cornerRadius = 5
        // 투명도가 있는 뷰 하위에 추가 되는 뷰에서 투명도 영향 받지 않기
        bottomView.backgroundColor = UIColor.systemGray.withAlphaComponent(0.1)
        bottomView.layer.cornerRadius = 5
        appImageView.layer.cornerRadius = 5
        appNameLabel.textColor = .white
        
    }
    
    
    func configure(_ intro: Intro) {
        titleLabel.text = intro.title
        nameLabel.text = intro.name
        descriptionLabel.text = intro.description
        thumbnailImageView.image = UIImage(named: intro.thumbnailImageName)
        
        if let url = URL(string: intro.appImage) {
            do {
                let data = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.appImageView.image = UIImage(data: data)
                }
            } catch {
                print("appImage download failed")
            }
        }
        
        appNameLabel.text = intro.appName
        appDescriptionLabel.text = intro.appDescription
        
    }
}
