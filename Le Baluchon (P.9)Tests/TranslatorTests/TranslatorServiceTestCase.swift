//
//  TranslatorServiceTestCase.swift
//  Le Baluchon (P.9)Tests
//
//  Created by fardi Issihaka on 18/10/2021.
//

import XCTest

@testable import Le_Baluchon__P_9_

class TranslatorServiceTestCase: XCTestCase {
    
    // MARK: - ❌ Failed: Je teste que il y'a une erreur (Et que j'ai le call back d'erreur)
    
    func test_GetTranslation_Should_Post_Failed_Callback_IfError() {
        // Given
        let translationService = TranslateService(
            session: URLSessionFake(data: nil, response: nil, error: FakeWeatherResponseData.error))
        
        // When
        let expectation = expectation(description: "Wait for queue change")
        translationService.getTranslation(for: "https://openclassrooms.com", target: "en", source: "fr") { result in
            // then
            XCTAssertNil(result)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - ❌ Failed: Je teste le cas ou il n'ya pas de donnée
    
    func test_GetTranslation_Should_Post_Failed_Callback_NoData() {
        // Given
        let translationService = TranslateService(
            session: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = expectation(description: "Wait for queue change")
        translationService.getTranslation(for: "https://openclassrooms.com", target: "en", source: "fr") { result in
            // then
            XCTAssertNil(result)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - ❌ Failed: Je teste la cas ou je reçois une reponse incorrect
    
    func test_GetTranslation_Should_Post_Failed_Callback_If_Incorrect_Response() {
        // Given
        let translationService = TranslateService(
            session: URLSessionFake(data: FakeTranslatorResponseData.translatorCorrectData, response: FakeTranslatorResponseData.responseKO, error: nil))
        
        // When
        let expectation = expectation(description: "Wait for queue change")
        translationService.getTranslation(for: "https://openclassrooms.com", target: "en", source: "fr") { result in
            // then
            XCTAssertNil(result)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - ❌ Failed: Je teste le cas ou j'ai des données incorrect
    
    func test_GetTranslation_Should_Post_Failed_Callback_If_Incorrect_Data() {
        // Given
        let translationService = TranslateService(
            session: URLSessionFake(data: FakeTranslatorResponseData.translatorIncorrectData, response: FakeTranslatorResponseData.responseOK, error: nil))
        
        // When
        let expectation = expectation(description: "Wait for queue change")
        translationService.getTranslation(for: "https://openclassrooms.com", target: "en", source: "fr") { result in
            // then
            XCTAssertNil(result)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - ✅ Success : Je teste le cas ou j'ai des données correct et une reponse correcte
    func test_GetTranslation_Should_Post_Success_Callback_If_NoError_And_CorrectData() {
        // Given
        let translationService = TranslateService(
            session: URLSessionFake(data: FakeTranslatorResponseData.translatorCorrectData, response: FakeTranslatorResponseData.responseOK, error: nil))
        
        // When
        let expectation = expectation(description: "Wait for queue change")
        translationService.getTranslation(for: "https://openclassrooms.com", target: "en", source: "fr") { result in
            // then
            let translatedText = "Les vies des Noirs comptent"
            
            XCTAssertNotNil(result)
            XCTAssertEqual(translatedText, result?.data.translations[0].translatedText)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
