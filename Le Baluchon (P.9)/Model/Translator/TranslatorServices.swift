//
//  TranslatorServices.swift
//  Le Baluchon (P.9)
//
//  Created by fardi Issihaka on 24/09/2021.
//

import Foundation

let key = "AIzaSyCg0w8C-0jkiJrczgul2LJNXPa79FtS8hE"

var textTranslated: String = ""

class TranslateService {
    
    // Pattern Singleton
    static let shared = TranslateService()
    private init() {}
    
    enum APIError: Error {
        case error(_errorString: String)
    }
    
    private var task: URLSessionDataTask?
    
    func getTranslation(for text: String, completion: @escaping (Result<TranslationResponse,APIError>) -> Void){
        
        let request = createTranslateRequest(text: text)
        
        let session = URLSession(configuration: .default)
        task = session.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                
                guard let data = data, error == nil else {
                    completion(.failure(.error(_errorString: "Error: data corrupt")))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(.failure(.error(_errorString: "Error: response corrupt")))
                    return
                }
                
                guard let responseJSON = try? JSONDecoder().decode(TranslationResponse.self, from: data) else {
                    completion(.failure(.error(_errorString: "Error: responseJson corrupt")))
                    return
                }
                completion(.success(responseJSON))
                textTranslated.append(responseJSON.data.translations[0].translatedText)
                print(textTranslated)
            }
        }
        task?.resume()
    }
    
    private func createTranslateRequest(text: String) -> URLRequest {
        let baseURLString = "https://translation.googleapis.com/language/translate/v2"
        var components = URLComponents(string: baseURLString)!
        let urlParams = ["q": text, "target": "en", "format": "text", "source": "fr", "model": "base", "key": "AIzaSyCg0w8C-0jkiJrczgul2LJNXPa79FtS8hE"]
        components.queryItems = urlParams.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
        var request = URLRequest(url: URL(string: baseURLString)!)
        request.url = components.url
        
        request.httpMethod = "POST"
        request.setValue("application/Json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
