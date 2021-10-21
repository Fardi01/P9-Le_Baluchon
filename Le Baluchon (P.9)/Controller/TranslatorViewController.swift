//
//  TraductionViewController.swift
//  Le Baluchon (P.9)
//
//  Created by fardi Issihaka on 19/09/2021.
//

import UIKit

class TranslatorViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    
    @IBOutlet weak var textToTranslateTextfield: UITextField!
    @IBOutlet weak var texteWasTranslatedLabel: UILabel!
    
    var reversalArrowButton: Bool = false
    
    var target: String = "en"
    var source: String = "fr"
    
    var refresh = UIRefreshControl.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        texteWasTranslatedLabel.text = ""
        textToTranslateTextfield.placeholder = "Écrivez votre texte ici pour le traduire en Anglais"
        
    }
    
    // MARK: - Buttons Action
    
    @IBAction func reversalButtonTapped() {
        manageReversalButton()
    }
    
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textToTranslateTextfield.resignFirstResponder()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        makeAPICall()
        return true
    }
    
}


// MARK: - MANAGE API CALL

extension TranslatorViewController {
    
    private func makeAPICall() {
        TranslateService.shared.getTranslation(for: textToTranslateTextfield.text ?? "", target: target, source: source) { [self] (result) in
            switch result {
            case .some(let response):
                self.updateTranslatorDisplay(response: response)
            case .none:
            presentAlert()
            }
        }
    }
    
    private func updateTranslatorDisplay(response: TranslationResponse) {
        if textToTranslateTextfield.text != "" {
            self.texteWasTranslatedLabel.text = response.data.translations[0].translatedText
        } else {
            texteWasTranslatedLabel.text = ""
        }
    }

}



// MARK: - MANAGE REVERSAL BUTTON

extension TranslatorViewController {
    
    private func manageReversalButton() {
        if reversalArrowButton {
            reversalArrowButton = false
            sourceLabel.text = "Français"
            targetLabel.text = "Anglais"
            target = "en"
            source = "fr"
            textToTranslateTextfield.placeholder = "Écrivez votre texte ici pour le traduire en Anglais"
        } else {
            reversalArrowButton = true
            sourceLabel.text = "Anglais"
            targetLabel.text = "Français"
            target = "fr"
            source = "en"
            textToTranslateTextfield.placeholder = "Write your text here to translate it into French"
        }
    }
}

// MARK: - MANAGE TEXT TRANSLATED VIEW

extension TranslatorViewController {
    func translateTextfield() {
        if ((textToTranslateTextfield.text?.isEmpty) != nil) {
            texteWasTranslatedLabel.text = ""
        }
    }
}



// MARK: - MANAGE ALERTS

extension TranslatorViewController {
    
    private func presentAlert() {
        let alertVC = UIAlertController.init(title: "Une erreur est survenue", message: "error de chargement", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}





#warning("Chercher comment supprimer le texte en même temps sur le texte traduit")
