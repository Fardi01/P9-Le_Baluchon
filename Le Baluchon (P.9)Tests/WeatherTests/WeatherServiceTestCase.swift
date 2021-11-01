//
//  Le_Baluchon__P_9_Tests.swift
//  Le Baluchon (P.9)Tests
//
//  Created by fardi Issihaka on 18/09/2021.
//

import XCTest
@testable import Le_Baluchon__P_9_

class WeatherServiceTestCase: XCTestCase {
    
    // MARK: - ❌ Failed: Test if callback Error
    
    func testGetWeatherShouldPostFailedCallbackIfError() {
        // Given
        let weatherService = WeatherServices(
            session: URLSessionFake(data: nil, response: nil, error: FakeWeatherResponseData.error))
        
        // When
        let expectation = XCTestExpectation(description: "wait for queue change.")
        weatherService.getWeather(urlString: "https://openclassroom.com") { (response) in
            // Then
            XCTAssertNil(response)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    // MARK: - ❌ Failed: No Datas, No Responses and No Errors
    
    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        // Given
        let weatherService = WeatherServices(
            session: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "wait for queue change.")
        weatherService.getWeather(urlString: "https://openclassroom.com") { (response) in
            // Then
            XCTAssertNil(response)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    // MARK: - ❌ Failed: Incorrect Responses
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let weatherService = WeatherServices(
            session: URLSessionFake(data: FakeWeatherResponseData.weatherCorrectData, response: FakeWeatherResponseData.responseKO, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "wait for queue change.")
        weatherService.getWeather(urlString: "https://openclassroom.com") { (response) in
            // Then
            XCTAssertNil(response)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - ❌ Failed: Incorrect Datas
    
    func testGetWeatherShouldPostFailedCallbackIfiIncorrectData() {
        // Given
        let weatherService = WeatherServices(
            session: URLSessionFake(data: FakeWeatherResponseData.weatherIncorrectData, response: FakeWeatherResponseData.responseOK, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "wait for queue change.")
        weatherService.getWeather(urlString: "https://openclassroom.com") { (response) in
            // Then
            XCTAssertNil(response)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    // MARK: - ✅ Success : Correct datas and correct responses
    
    func testGetWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let weatherService = WeatherServices(
            session: URLSessionFake(data: FakeWeatherResponseData.weatherCorrectData, response: FakeWeatherResponseData.responseOK, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "wait for queue change.")
        weatherService.getWeather(urlString: "https://openclassroom.com") { (result) in
            // Then
            let description = "ciel dégagé"
            let temp = 17.52
            let icon = "01d"
            XCTAssertNotNil(result)
            XCTAssertEqual(description, result?.weather[0].description)
            XCTAssertEqual(temp, result?.main.temperature)
            XCTAssertEqual(icon, result?.weather[0].icon)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
}
