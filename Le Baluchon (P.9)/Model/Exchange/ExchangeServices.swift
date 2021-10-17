//
//  ExchangeServices.swift
//  Le Baluchon (P.9)
//
//  Created by fardi Issihaka on 24/09/2021.
//

import Foundation

class ExchangeService {
    static let shared = ExchangeService()
    private init() {}
    
    enum APIError: Error {
        case error(_errorString: String)
    }
    
    private static let exchangeUrl = URL(string: "http://data.fixer.io/api/latest?access_key=f5375c0855f19cf1e96cab96c2b47f79")!
    
    private var session = URLSession(configuration: .default)
    
    private var task: URLSessionDataTask?
    
    func getExchange(completion: @escaping (Result<ExchangeResponse,APIError>) -> Void) {
        
        var request = URLRequest(url: ExchangeService.exchangeUrl)
        request.httpMethod = "Get"
        
        task = session.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                
                guard let data = data, error == nil else {
                    completion(.failure(.error(_errorString: "Error: data corrupt")))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(.failure(.error(_errorString: "Error: Response corrupt")))
                    return
                }
                
                guard let responseJSON = try? JSONDecoder().decode(ExchangeResponse.self, from: data) else {
                    completion(.failure(.error(_errorString: "Error: ResponseJson corrupt")))
                    return
                }
                
                
                completion(.success(responseJSON))
                print(responseJSON)
            }
        }
        task?.resume()
    }
}
