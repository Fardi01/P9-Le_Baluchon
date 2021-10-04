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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        eurosTextfield.resignFirstResponder()
    }
    
}


// ⚠️ Si la conversion se fait automatiquement, laisser bouton return du clavier cacher le clavier, si non utiliser le bouton pour lancer la conversion. 
