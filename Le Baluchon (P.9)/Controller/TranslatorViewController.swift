//
//  TraductionViewController.swift
//  Le Baluchon (P.9)
//
//  Created by fardi Issihaka on 19/09/2021.
//

import UIKit

class TranslatorViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var frenchLabel: UILabel!
    @IBOutlet weak var englishLabel: UILabel!
    
    @IBOutlet weak var textToTranslateTextfield: UITextField!
    @IBOutlet weak var texteWasTranslatedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Buttons Action
    
    @IBAction func reverseButtonTapped(_ sender: UIButton) {
        // Modifier le sens de la traduction 
    }
    
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textToTranslateTextfield.resignFirstResponder()
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        makeAPICall()
        return true
    }
    
}

// MARK: - Private functions

extension TranslatorViewController {
    
    private func makeAPICall() {
        TranslateService.shared.getTranslation(for: textToTranslateTextfield.text ?? "") { [self] (result: Result<TranslationResponse,TranslateService.APIError>) in
            switch result {
            case .success(let response):
                self.translate(response: response)
            case .failure(let error):
            presentAlert(with: error.localizedDescription)
            }
            
        }
    }
    
    private func translate(response: TranslationResponse) {
        self.texteWasTranslatedLabel.text = response.data.translations[0].translatedText
        
    }
    
}

// MARK: - Alerts

extension TranslatorViewController {
    
    private func presentAlert(with error: String) {
        let alertVC = UIAlertController.init(title: "Une erreur est survenue", message: error, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}


#warning("<#T##message###>")
// A implementer : En affichant la vue, la vue du hello world est caché, dès que je clique sur le textFiel, la vue du hello world apparait. 
