//
//  SymbolRollerViewController.swift
//  SybolRoller
//
//  Created by heyji on 2022/05/10.
//

import UIKit

class SymbolRollerViewController: UIViewController {
    
    let symbols: [String] = ["sun.min", "moon", "cloud", "wind", "snowflake"]

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var label: UILabel!
    @IBOutlet var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reload()
        button.tintColor = UIColor.systemPink
    }
    
    func reload() {
        let symbol = symbols.randomElement()!
        imageView.image = UIImage(systemName: symbol)
        label.text = symbol
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        reload()
    }
}
