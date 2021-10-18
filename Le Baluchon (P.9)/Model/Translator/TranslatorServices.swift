//
//  TranslatorServices.swift
//  Le Baluchon (P.9)
//
//  Created by fardi Issihaka on 24/09/2021.
//

import Foundation

class TranslateService {
    // Pattern Singleton
    static let shared = TranslateService()
    private init() {}
    
    enum APIError: Error {
        case error(_errorString: String)
    }
    
    enum ReverseLanguage {
        case target(to: String)
        case source(from: String)
    }
    
    private var task: URLSessionDataTask?
    
    private var session = URLSession(configuration: .default)
    init(session: URLSession) {
        self.session = session
    }
    
    func getTranslation(for text: String, completion: @escaping (_ result: TranslationResponse?) -> Void){
        
        let request = createTranslateRequest(text: text)
        
        let session = URLSession(configuration: .default)
        task = session.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                
                guard let data = data, error == nil else {
                    completion(.none)
                    //completion(.failure(.error(_errorString: "Error: data corrupt")))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(.none)
                    //completion(.failure(.error(_errorString: "Error: response corrupt")))
                    return
                }
                
                guard let responseJSON = try? JSONDecoder().decode(TranslationResponse.self, from: data) else {
                    completion(.none)
                    //completion(.failure(.error(_errorString: "Error: responseJson corrupt")))
                    return
                }
                completion(.some(responseJSON))
                //completion(.success(responseJSON))
                
            }
        }
        task?.resume()
    }
    
    // MARK: - Private Func
    
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
