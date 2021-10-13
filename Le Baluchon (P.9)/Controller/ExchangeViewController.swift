//
//  ExchangeViewController.swift
//  Le Baluchon (P.9)
//
//  Created by fardi Issihaka on 19/09/2021.
//

import UIKit

class ExchangeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var eurosTextfield: UITextField!
    @IBOutlet weak var dollarLabel: UILabel!
    
    var selectedCurrency: Double = 0.00
    var expectedValue: Double = 0.00
    var inputValue: Double = 0.00
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //textField.resignFirstResponder()
        ExchangeService.shared.getExchange { (result: Result<ExchangeResponse,ExchangeService.APIError>) in
            switch result {
            case .success(let success):
                self.currencyChange(response: success)
            case .failure(let failure):
                self.presentAlert(with: failure.localizedDescription)
            }
        }
        return true
    }
    
    private func currencyChange(response: ExchangeResponse) {
        selectedCurrency = response.rates.EUR
        expectedValue = response.rates.USD
        inputValue = Double(eurosTextfield.text!)!
        
        
        let conversion = (inputValue * expectedValue / selectedCurrency)
        
        
        if eurosTextfield.text != "" {
            dollarLabel.text = String(conversion)
            //dollarLabel.text = String(format: "%.2f")
        }
        print(conversion)
    }

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        eurosTextfield.resignFirstResponder()
    }
    
    
    private func presentAlert(with error: String) {
        let alertVC = UIAlertController.init(title: "Une erreur est survenue", message: error, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
}


// ⚠️ Si la conversion se fait automatiquement, laisser bouton return du clavier cacher le clavier, si non utiliser le bouton pour lancer la conversion. 
