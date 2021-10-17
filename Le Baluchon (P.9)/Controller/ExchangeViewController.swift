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
        makeAPICall()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        makeAPICall()
        return true
    }

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        eurosTextfield.resignFirstResponder()
    }
    
}


// MARK: - Call API Functions

extension ExchangeViewController {
    
    private func makeAPICall() {
        ExchangeService.shared.getExchange { (result: Result<ExchangeResponse,ExchangeService.APIError>) in
            switch result {
            case .success(let success):
                self.currencyChange(response: success)
            case .failure(let failure):
                self.presentAlert(with: failure.localizedDescription)
            }
        }
    }
    
    
    private func currencyChange(response: ExchangeResponse) {
        selectedCurrency = response.rates.EUR
        expectedValue = response.rates.USD
        inputValue = Double(eurosTextfield.text!) ?? 1.00
        
        var conversion = (inputValue * expectedValue / selectedCurrency)
        conversion = round(conversion * 100) / 100
        
        if eurosTextfield.text != "" {
            dollarLabel.text = String(conversion)
        } else {
            var USDRate = response.rates.USD
            USDRate = round(USDRate * 100) / 100
            dollarLabel.text = String(USDRate)
        }
    }
}



// MARK: - Present UIAlert

extension ExchangeViewController {
    
    private func presentAlert(with error: String) {
        let alertVC = UIAlertController.init(title: "Une erreur est survenue", message: error, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}

#warning("Chercher comment supprimer en même temps le nombre converti")
