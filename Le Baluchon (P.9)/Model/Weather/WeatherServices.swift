//
//  WeatherServices.swift
//  Le Baluchon (P.9)
//
//  Created by fardi Issihaka on 24/09/2021.
//

import Foundation

class WeatherServices {
    
    static let shared = WeatherServices()
    private init() {}
    
    enum APIError: Error {
        case error(_errorString: String)
    }
    
    func getWeather(urlString: String, completion: @escaping (Result<Response,APIError>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.error(_errorString: "Error: Invalid URL")))
            return
        }
        
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                
                
                guard let data = data, error == nil else {
                    completion(.failure(.error(_errorString: "Error: data corrupt")))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(.failure(.error(_errorString: "Error: Response corrupt")))
                    return
                }
                
                guard let responseJSON = try? JSONDecoder().decode(Response.self, from: data) else {
                    completion(.failure(.error(_errorString: "Error: ResponseJson corrupt")))
                    return
                }
                completion(.success(responseJSON))
                print(responseJSON)
                
            }
            
        }
        task.resume()
    }
    
}
