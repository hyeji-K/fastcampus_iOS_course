//
//  WeatherViewController.swift
//  SimpleWeather
//
//  Created by heyji on 2022/05/11.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var weatherImageView: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    let cities = ["Seoul", "Tokyo", "LA", "Seattle"]
    let weathers = ["cloud.fill", "sun.max.fill", "wind", "cloud.sun.rain.fill"]
    
    @IBAction func ChangeButtonTapped(_ sender: Any) {
        
        cityLabel.text = cities.randomElement()
        
        let imageName = weathers.randomElement()!
        weatherImageView.image = UIImage(systemName: imageName)?.withRenderingMode(.alwaysOriginal)
        
        let randomTemp = Int.random(in: 10..<30)
        temperatureLabel.text = "\(randomTemp)º "
    }
    
}
