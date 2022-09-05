//
//  NetworkDataFetcher.swift
//  MusicApp
//
//  Created by Илья Шаповалов on 05.07.2022.
//

import Foundation

protocol DataFetcher {
    func fetchGnericJSONData<T: Decodable>(urlString: String, authToken: String, response: @escaping (Result<T?, Error>) -> Void)
    func sendJSONData(urlString: String, authToken: String, data: [String: [String]], response: @escaping(Result<Bool, Error>) -> Void)
}

class NetworkDataManager: DataFetcher {
    
    var networking: Networking!
    
    init(networking: Networking = NetworkService()) {
        self.networking = networking
    }
    
    func fetchGnericJSONData<T: Decodable>(urlString: String, authToken: String, response: @escaping(Result<T?, Error>) -> Void) {
        networking.GETrequest(urlString: urlString, authToken: authToken) { result in
            switch result {
            case .failure(let error):
                print("Error received requesting Data: \(error.localizedDescription)")
                response(.failure(error))
            case .success(let data):
            let decoded = self.decodeJSON(type: T.self, from: data)
            response(.success(decoded))
            }
        }
    }
    
    func sendJSONData(urlString: String, authToken: String, data: [String: [String]], response: @escaping(Result<Bool, Error>) -> Void) {
        guard let encodedData = encodeJSON(from: data) else { return }
        networking.PUTRequest(urlString: urlString, authToken: authToken, data: encodedData) { result in
            switch result {
            case .failure(let error):
                response(.failure(error))
            case .success(let status):
                response(.success(status))
            }
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = data else { return nil }
        do {
            let objects = try decoder.decode(T.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
        
    }
    
    private func encodeJSON(from data: [String: [String]]) -> Data? {
        let encoder = JSONEncoder()
        do {
            let objects = try encoder.encode(data)
            return objects
        } catch let jsonError {
            print("Failed to encode JSON: \(jsonError)")
            return nil
        }
    }
    
    
}
