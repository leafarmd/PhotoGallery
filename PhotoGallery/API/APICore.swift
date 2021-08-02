//
//  APICore.swift
//  PhotoGallery
//
//  Created by Rafael Mendes Damasceno on 29/07/21.
//

import Foundation
import UIKit

final class APICore: APIProtocols {
    
    let apiKey = "f9cc014fa76b098f9e82f1c288379ea1"
    
    func requestObject<T>(from endpoint: APIEndpoint,
                                 data: Data? = nil,
                                 type: T.Type,
                                 completion: @escaping CompletionCallback<T>) where T : Decodable {
        
        request(from: endpoint.url,
                type: type,
                method: endpoint.method,
                params: endpoint.params,
                data: data,
                completion: completion)
        
    }
    
    private func request<T: Decodable>(from endpoint: String,
                                              type: T.Type,
                                              method: HttpMethod,
                                              params: [String: String],
                                              data: Data?,
                                              completion: @escaping CompletionCallback<T>) {
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        var baseURL = URLComponents(string: endpoint)
        
        baseURL?.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "nojsoncallback", value: "1")
        ]
        
        params.forEach {
            baseURL?.queryItems?.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        
        guard let url = baseURL?.url else {
            completion(.failure(.malformedURL))
            return
        }
        
        var request : URLRequest = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let data = data {
            request.httpBody = data
        }
        
        
        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                
                guard error == nil else {
                    completion(.failure(.requestFailed))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                
                let decoder = JSONDecoder()
                
                do {
                    let dataType = try decoder.decode(type.self, from: data)
                    completion(.success(dataType))
                } catch {
                    completion(.failure(.decodingFailed))
                }
            }
        }.resume()
    }
    
    static func loadImage(from url: String, completion: @escaping RequestImageResult) {
        
        guard let url = URL(string: url) else {
            completion(.failure(.invalidData))
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            guard let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidData))
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(image))
            }
        } catch {
            DispatchQueue.main.async {
                completion(.failure(.invalidData))
            }
        }
    }
}
