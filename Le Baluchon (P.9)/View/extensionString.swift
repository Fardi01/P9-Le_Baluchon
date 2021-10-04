//
//  extensionString.swift
//  Le Baluchon (P.9)
//
//  Created by fardi Issihaka on 01/10/2021.
//

import Foundation


extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
