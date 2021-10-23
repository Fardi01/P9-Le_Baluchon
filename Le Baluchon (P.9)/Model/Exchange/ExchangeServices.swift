//
//  ExchangeServices.swift
//  Le Baluchon (P.9)
//
//  Created by fardi Issihaka on 24/09/2021.
//

import Foundation

class ExchangeService {
    static let shared = ExchangeService()
    
    private static let exchangeUrl = URL(string: "http://data.fixer.io/api/latest?access_key=f5375c0855f19cf1e96cab96c2b47f79")!
    
    private var task: URLSessionDataTask?
    
    private var session = URLSession(configuration: .default)
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getExchange(completion: @escaping (_ result: ExchangeResponse?) -> Void) {
        
        var request = URLRequest(url: ExchangeService.exchangeUrl)
        request.httpMethod = "Get"
        
        task = session.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                
                guard let data = data, error == nil else {
                    completion(.none)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(.none)
                    return
                }
                
                guard let responseJSON = try? JSONDecoder().decode(ExchangeResponse.self, from: data) else {
                    completion(.none)
                    return
                }
                
                completion(.some(responseJSON))
                print(responseJSON)
            }
        }
        task?.resume()
    }
}
