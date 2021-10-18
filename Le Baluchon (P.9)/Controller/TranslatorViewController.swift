//
//  TraductionViewController.swift
//  Le Baluchon (P.9)
//
//  Created by fardi Issihaka on 19/09/2021.
//

import UIKit

class TranslatorViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var leftSideLabel: UILabel!
    @IBOutlet weak var rightSideLabel: UILabel!
    
    @IBOutlet weak var textToTranslateTextfield: UITextField!
    @IBOutlet weak var texteWasTranslatedLabel: UILabel!
    
    var reverseButtonIsTapped: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Buttons Action
    
    @IBAction func reverseButtonTapped(_ sender: UIButton) {
        manageReverseButton()
    }
    
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textToTranslateTextfield.resignFirstResponder()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        makeAPICall()
        return true
    }
    
    private func manageReverseButton() {
        if reverseButtonIsTapped {
            reverseButtonIsTapped = false
            leftSideLabel.text = "Français"
            rightSideLabel.text = "Anglais"
        } else {
            reverseButtonIsTapped = true
            leftSideLabel.text = "Anglais"
            rightSideLabel.text = "Français"
        }
    }
    
}

// MARK: - Private functions

extension TranslatorViewController {
    
    private func makeAPICall() {
        TranslateService.shared.getTranslation(for: textToTranslateTextfield.text ?? "") { [self] (result) in
            switch result {
            case .some(let response):
                self.translate(response: response)
            case .none:
            presentAlert()
            }
        }
    }
    
    private func translate(response: TranslationResponse) {
        if textToTranslateTextfield.text != "" {
            self.texteWasTranslatedLabel.text = response.data.translations[0].translatedText
        } else {
            texteWasTranslatedLabel.text = ""
        }
    }
    
}

// MARK: - Alerts

extension TranslatorViewController {
    
    private func presentAlert() {
        let alertVC = UIAlertController.init(title: "Une erreur est survenue", message: "error de chargement", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}


#warning("Gérer l'échange de traduction Français -> Anglais et Anglais -> Francais")
#warning("Chercher comment supprimer le texte en même temps sur le texte traduit")
