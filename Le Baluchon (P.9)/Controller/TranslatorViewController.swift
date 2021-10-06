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
    
    static var text: String = "Hello_you"
    
    
    // Faire un sitch pour changer la langue source et la langue cible
    
    let translatorUrl = "https://translation.googleapis.com/language/translate/v2?q=\(text)&target=fr&format=text&source=en&model=base&key=AIzaSyCg0w8C-0jkiJrczgul2LJNXPa79FtS8hE"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var myThin = textToTranslateTextfield.text

        TranslateService.shared.getTranslation(urlString: translatorUrl, source: textToTranslateTextfield.text ?? "Hello") { [self] (result: Result<TranslationResponse,TranslateService.APIError>) in
            switch result {
            case .success(let response):
                self.translate(response: response)
            case .failure(let error):
            presentAlert(with: error.localizedDescription)
            }
            
        }
    }
    
    @IBAction func reverseButtonTapped(_ sender: UIButton) {
        // Modifier le sens de la traduction 
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textToTranslateTextfield.resignFirstResponder()
        
    }
    
    private func setupTextfield() {
        
    }
    
    private func translate(response: TranslationResponse) {
        self.texteWasTranslatedLabel.text = response.data.translations[0].translatedText
        
    }
    
    private func presentAlert(with error: String) {
        let alertVC = UIAlertController.init(title: "Une erreur est survenue", message: error, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
}

// ⚠️ Si la conversion se fait automatiquement, laisser bouton return du clavier cacher le clavier, si non utiliser le bouton pour lancer la conversion.


// A implementer : En affichant la vue, la vue du hello world est caché, dès que je clique sur le textFiel, la vue du hello world apparait. 
