//
//  TranslatorServices.swift
//  Le Baluchon (P.9)
//
//  Created by fardi Issihaka on 24/09/2021.
//

import Foundation

let key = "AIzaSyCg0w8C-0jkiJrczgul2LJNXPa79FtS8hE"


class TranslateService {
    
    static let shared = TranslateService()
    private init() {}
    
    enum APIError: Error {
        case error(_errorString: String)
    }
    
    
    func getTranslation(urlString: String, completion: @escaping (Result<TranslationResponse,APIError>) -> Void){
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.error(_errorString: "Error: Invalid URL")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/Json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            
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
                print(responseJSON)
            }
        }
        task.resume()
    }
}
