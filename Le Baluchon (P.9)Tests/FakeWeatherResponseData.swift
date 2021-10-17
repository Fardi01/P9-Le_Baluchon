//
//  FakeResponseData.swift
//  Le Baluchon (P.9)Tests
//
//  Created by fardi Issihaka on 09/10/2021.
//

import Foundation

class FakeWeatherResponseData {
    // MARK: - Data
    static var weatherCorrectData: Data {
        let bundle = Bundle(for: FakeWeatherResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static let weatherIncorrectData = "error".data(using: .utf8)
    
    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://github.com")!,
        statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://github.com")!,
        statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    // MARK: - Error
    class WeatherError: Error{}
    static let error = WeatherError()
    
}
