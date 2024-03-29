//
//  APIProtocols.swift
//  PhotoGallery
//
//  Created by Rafael Mendes Damasceno on 29/07/21.
//

import Foundation
import UIKit

public protocol APIProtocols: AnyObject {
    func requestObject<T: Decodable>(from endpoint: APIEndpoint, data: Data?, type: T.Type, completion: @escaping CompletionCallback<T>)
    func loadImage(from endpoint: APIEndpoint, completion: @escaping RequestImageResult)
}

public enum RequestError: Error {
    case malformedURL
    case requestFailed
    case invalidData
    case decodingFailed
    
    public var message: String {
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

public enum HttpMethod: String {
    case POST
    case GET
}

public typealias RequestImageResult = (Result<UIImage, RequestError>) -> Void
public typealias CompletionCallback<T: Decodable> = (Result<T, RequestError>) -> Void
