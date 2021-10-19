//
//  FakeTranslatorResponseData.swift
//  Le Baluchon (P.9)Tests
//
//  Created by fardi Issihaka on 18/10/2021.
//

import Foundation

class FakeTranslatorResponseData {
    // MARK: - Data
    static var translatorCorrectData: Data {
        let bundle = Bundle(for: FakeTranslatorResponseData.self)
        let url = bundle.url(forResource: "Translate", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static let translatorIncorrectData = "error".data(using: .utf8)
    
    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://github.com")!,
        statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://github.com")!,
        statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    // MARK: - Error
    class TranslatorError: Error{}
    static let error = TranslatorError()
}
