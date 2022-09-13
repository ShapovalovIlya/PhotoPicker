//
//  NetworkService.swift
//  MusicApp
//
//  Created by Илья Шаповалов on 05.07.2022.
//

import Foundation

protocol Networking {
    func GETrequest(urlString: String, completion: @escaping(Result<Data?, Error>) -> Void)
    func PUTRequest(urlString: String, data: Data, complition: @escaping(Result<Bool, Error>) -> Void)
}

final class NetworkService: Networking {
    
    func GETrequest(urlString: String, completion: @escaping (Result<Data?, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let request = createURLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    func PUTRequest(urlString: String, data: Data, complition: @escaping(Result<Bool, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let request = createURLRequest(url: url, method: .PUT)
        let task = createUploadTask(from: request, with: data, complition: complition)
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Result<Data?, Error>) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let httpResponce = response as? HTTPURLResponse {
                    print("Server responce: \(httpResponce.statusCode)")
                }
                
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(data))
                }
            }
        }
    }
    
    private func createUploadTask(from request: URLRequest, with data: Data, complition: @escaping(Result<Bool, Error>) -> Void) -> URLSessionUploadTask {
        return URLSession.shared.uploadTask(with: request, from: data) { responceData, responce, error in
            DispatchQueue.main.async {
                
                if let error = error {
                    print("Network service error. PUT requrst failure: \(error.localizedDescription)")
                    complition(.failure(error))
                }
                
                guard let statusCode = (responce as? HTTPURLResponse)?.statusCode else { return }
                print("Server responce: \(statusCode)")
                switch statusCode {
                case 200:
                    complition(.success(true))
                default:
                    complition(.success(false))
                }
                
            }
        }
    }
    
    private func createURLRequest(url: URL, method: HTTPMethod = HTTPMethod.GET) -> URLRequest {
        var request = URLRequest(url: url)
        
        switch method {
        case .GET:
            request.httpMethod = "GET"
        case .PUT:
            request.httpMethod = "PUT"
        case .POST:
            request.httpMethod = "POST"
        case .DELETE:
            request.httpMethod = "DELETE"
        }
        
        request.setValue("v1", forHTTPHeaderField: "Accept-Version")
        
        return request
    }
    
}

fileprivate enum HTTPMethod {
    case GET
    case PUT
    case POST
    case DELETE
}
