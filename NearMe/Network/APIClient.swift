//
//  APIClient.swift
//  NearMe
//
//  Created by Eren Besel on 2019/08/21.
//  Copyright © 2019 Eren Besel. All rights reserved.
//

import Foundation

/// `APIClient` class handles connecting to network APIs that don't have their own API clients, i.e., to make direct requests to any open API urls.
struct APIClient: APIRequestable {
    
    func sendRequest<T: API>(for api: T, completion: @escaping (Result<T.ResponseType, APIError>) -> Void) {
        guard let request = prepareRequest(for: api) else {
            return
        }
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                // Check Http status code and errors
                let httpURLResponse = response as? HTTPURLResponse
                guard let response = httpURLResponse, response.statusCode == 200 else {
                    var apiError = APIError.unknown
                    if let error = error as NSError? {
                        if error.code == -1001 {
                            // Time out
                            apiError = .timeout
                        } else {
                            apiError = .httpError(error.code)
                        }
                    } else if httpURLResponse?.statusCode == 404 { // This falls in checking some of http status code
                        // Not found
                        apiError = .notFound
                    }
                    completion(Result.failure(apiError))
                    return
                }
                
                guard let data = data else {
                    completion(Result.failure(APIError.badJson(nil)))
                    return
                }
                let decoder = JSONDecoder()
                
                DispatchQueue.global(qos: .background).async {
                    var result: Result<T.ResponseType, APIError>
                
                    do {
                        let object = try decoder.decode(T.ResponseType.self, from: data)
                        result = Result.success(object)
                    } catch let error {
                        result = Result.failure(APIError.badJson(error.localizedDescription))
                    }
                    
                    DispatchQueue.main.async {
                        completion(result)
                    }
                }
            }
        }).resume()
    }
    
    private func prepareRequest<T: API>(for api: T) -> URLRequest? {
        guard let url = URL(string: api.path) else {
            return nil
        }
        
        var request: URLRequest?
        
        if api.httpMethod == .get {
            var queryItems = [URLQueryItem]()
            
            // add default params which exist in all requests
            api.defaultParameters.forEach { key, value in
                queryItems.append(URLQueryItem(name: key, value: "\(value)"))
            }
            
            api.parameters.forEach { key, value in
                queryItems.append(URLQueryItem(name: key, value: "\(value)"))
            }
            
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            components.queryItems = queryItems
            
            guard let newUrl = components.url else {
                return nil
            }
            request = URLRequest(url: newUrl, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: api.timeout)
        } else if api.httpMethod == .post {
            
            request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: api.timeout)
            request?.httpBody = try? JSONSerialization.data(withJSONObject: api.parameters, options: [])
        }
        
        for (key, value) in api.headers {
            request?.setValue(value, forHTTPHeaderField: key)
        }
        request?.httpMethod = api.httpMethod.rawValue
        
        return request
    }
}
