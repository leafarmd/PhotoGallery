//
//  APIProtocols.swift
//  PhotoGallery
//
//  Created by Rafael Mendes Damasceno on 29/07/21.
//

import Foundation
import UIKit

protocol APIProtocols: AnyObject {
    func requestObject<T: Decodable>(from endpoint: APIEndpoint, data: Data?, type: T.Type, completion: @escaping CompletionCallback<T>)
}

enum CompletionStatus<T> {
    case success(T)
    case failure(RequestError)
}

enum RequestError: Error {
    case malformedURL
    case requestFailed
    case invalidData
    case decodingFailed
    
    var message: String {
        switch self {
        case .malformedURL:
            return "error with URL requested"
        case .requestFailed:
            return "error with request"
        case .invalidData:
            return "invalid data"
        case .decodingFailed:
            return "data decode failed"
        }
    }
}

enum HttpMethod: String {
    case POST
    case GET
}

typealias RequestResult<T> = Result<T, RequestError>
typealias RequestImageResult = (Result<UIImage, RequestError>) -> Void
typealias CompletionCallback<T: Decodable> = (CompletionStatus<T>) -> Void
