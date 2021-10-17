//
//  Le_Baluchon__P_9_Tests.swift
//  Le Baluchon (P.9)Tests
//
//  Created by fardi Issihaka on 18/09/2021.
//

import XCTest
@testable import Le_Baluchon__P_9_

class WeatherServiceTestCase: XCTestCase {
    
    // Je teste que il y'a une erreur (Et que j'ai le call back d'erreur)
    func testGetWeatherShouldPostFailedCallbackIfError() {
        // Given
        let weatherService = WeatherServices(
            session: URLSessionFake(data: nil, response: nil, error: FakeWeatherResponseData.error))
        
        // When
        let expectation = XCTestExpectation(description: "wait for queue change.")
        weatherService.getWeather(urlString: "https://openclassroom.com") { (response) in
            // Then
            XCTAssertNil(response)
            //XCTAssertNotNil(response)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }

}
