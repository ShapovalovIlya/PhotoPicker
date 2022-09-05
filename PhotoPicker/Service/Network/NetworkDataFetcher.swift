//
//  NetworkDataFetcher.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 05.09.2022.
//

import Foundation

protocol DataFetcherServiceProtocol {
    func fetchPhotos(_ complition: @escaping(Result<[PhotoData]?, Error>) -> Void)
}

final class DataFetcherService: DataFetcherServiceProtocol {
    
    private let dataFetcher: DataManager?
    private let baseURL = "https://api.unsplash.com/"
    private let API = APIKeys()
    
    init(dataFetcher: DataManager = NetworkDataManager()) {
        self.dataFetcher = dataFetcher
    }
    
    func fetchPhotos(_ complition: @escaping(Result<[PhotoData]?, Error>) -> Void) {
        let fullURL = "\(baseURL)/photos?client_id=\(API.accessKey)"
        dataFetcher?.fetchGnericJSONData(urlString: fullURL, response: complition)
    }
    
}
