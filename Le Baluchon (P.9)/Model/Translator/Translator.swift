//
//  TranslatorAPI.swift
//  Le Baluchon (P.9)
//
//  Created by fardi Issihaka on 01/10/2021.
//

import Foundation

struct TranslationResponse: Codable {
    struct Data: Codable {
        struct Translations: Codable {
            let translatedText: String
        }
        let translations: [Translations]
    }
    let data : Data
}

// MARK: - Json Response

//
//{
//    "data": {
//        "translations": [
//            {
//                "translatedText": "Les vies des Noirs comptent"
//            }
//        ]
//    }
//}
