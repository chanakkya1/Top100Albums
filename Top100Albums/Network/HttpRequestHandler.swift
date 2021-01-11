//
//  HttpRequestHandler.swift
//  Top100Albums
//
//  Created by chanakkya mati on 1/11/21.
//

import Foundation

protocol HttpRequestHandlerType {
    func jsonRequest<ResponseEntity: Codable>(_ request: URLRequest, completionHandler: @escaping (Result<ResponseEntity, Error>) -> Void)
}

class HttpRequestHandler:  HttpRequestHandlerType {

    private let session: URLSession = {
        let configuration: URLSessionConfiguration  = {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 40.0
            return configuration
        }()

        return URLSession(configuration: configuration)
    }()

    func jsonRequest<ResponseEntity: Codable>(_ request: URLRequest, completionHandler: @escaping (Result<ResponseEntity, Error>) -> Void) {
        let completionHandlerOnMainThread: (Result<ResponseEntity, Error>) -> Void  = { result in
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }

        let dataTask = session.dataTask(with: request) { (data, urlResponse, error) in
            if let error = error {
                completionHandlerOnMainThread(.failure(error))
                return
            }

            guard let responseData = data,
                  let httpUrlResponse = urlResponse as? HTTPURLResponse,
                  (200..<300).contains(httpUrlResponse.statusCode) else {
                completionHandlerOnMainThread(.failure(NetworkError.serverError(urlResponse, data)))
                return
            }

            do {
                let jsonResponse =  try JSONDecoder().decode(ResponseEntity.self, from: responseData)
                completionHandlerOnMainThread(.success(jsonResponse))
            } catch  let decodingError {
                completionHandlerOnMainThread(.failure(decodingError))
            }
        }

        dataTask.resume()
    }

    enum NetworkError: Error {
        case serverError(URLResponse?, Data?)
    }
}
