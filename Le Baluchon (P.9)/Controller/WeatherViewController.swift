//
//  MeteoViewController.swift
//  Le Baluchon (P.9)
//
//  Created by fardi Issihaka on 19/09/2021.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionNYC: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureNYC: UILabel!
    @IBOutlet weak var descriptionSTRG: UILabel!
    @IBOutlet weak var temperatureSTRG: UILabel!
    @IBOutlet weak var ressentiTemp: UILabel!
    @IBOutlet weak var tempMini: UILabel!
    @IBOutlet weak var tempMaxi: UILabel!
    @IBOutlet weak var tempMinSTRG: UILabel!
    @IBOutlet weak var tempMaxSTRG: UILabel!
    
    let newYorkWeatherURL =  "https://api.openweathermap.org/data/2.5/weather?id=5128581&appid=382942f8313f808eaf8a98568b273c65&units=metric&lang=fr"
    
    let STRGWeatherURL = "https://api.openweathermap.org/data/2.5/weather?q=strasbourg&appid=382942f8313f808eaf8a98568b273c65&units=metric&lang=fr"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        date()
        weatherUpdate()
    }
}


extension WeatherViewController {
    
    private func weatherUpdate() {
        WeatherServices.shared.getWeather(urlString: newYorkWeatherURL) { (result: Result<Response,WeatherServices.APIError>) in
            switch result {
            case .success(let response):
                self.updateNYC(response: response)
            case .failure(let error):
                self.presentAlert(with: error.localizedDescription)
            }
        }
        WeatherServices.shared.getWeather(urlString: STRGWeatherURL) { (result: Result<Response,WeatherServices.APIError>) in
            switch result {
            case .success(let response):
                self.updateSTRG(response: response)
            case .failure(let error):
                self.presentAlert(with: error.localizedDescription)
            }
        }
    }
}


extension WeatherViewController {
    
    private func updateNYC(response: Response) {
        self.descriptionNYC.text = response.weather[0].description.capitalizingFirstLetter()
        self.temperatureNYC.text = "\(Int(response.main.temperature.rounded()))°C"
        self.ressentiTemp.text = "\(Int(response.main.feelsLike.rounded()))°"
        self.tempMini.text = "\(Int(response.main.tempMin.rounded()))°"
        self.tempMaxi.text = "\(Int(response.main.tempMax.rounded()))°"
        
        if let data = try? Data(contentsOf: response.weather[0].weatherIconURL){
            self.weatherIcon.image = UIImage(data: data)
        }
    }
    
    private func updateSTRG(response: Response) {
        self.descriptionSTRG.text = response.weather[0].description.capitalizingFirstLetter()
        self.temperatureSTRG.text = "\(Int(response.main.temperature.rounded()))°C"
        self.tempMinSTRG.text = "Min.\(Int(response.main.tempMin.rounded()))°"
        self.tempMaxSTRG.text = "Max.\(Int(response.main.tempMax.rounded()))°"
    }

    private func presentAlert(with error: String) {
        let alertVC = UIAlertController.init(title: "Une erreur est survenue", message: error, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}


extension WeatherViewController {
    
    private func date() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fr_FR")
        dateFormatter.dateStyle = .full
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "EEEE d MMMM yyyy"
        dateLabel.text = dateFormatter.string(from: date).capitalizingFirstLetter()
    }
    
}

