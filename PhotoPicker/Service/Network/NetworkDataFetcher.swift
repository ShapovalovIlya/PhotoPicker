//
//  NetworkDataFetcher.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 05.09.2022.
//

import Foundation

protocol DataFetcherServiceProtocol {
    
}

final class DataFetcherService {
    
    private let dataFetcher: DataFetcher!
    private let baseURL = "https://api.unsplash.com/"
    private let API = APIKeys()
    
    init(dataFetcher: DataFetcher = NetworkDataManager()) {
        self.dataFetcher = dataFetcher
    }
    
    func fetchRandomPhoto() {
        let fullURL = "\(baseURL)/photos/random?client_id=\(API.accessKey)"
        
    }
    
}
