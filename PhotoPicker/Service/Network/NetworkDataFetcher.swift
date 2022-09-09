//
//  NetworkDataFetcher.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 05.09.2022.
//

import Foundation

protocol DataFetcherServiceProtocol {
    func fetchListOfPhotos(_ complition: @escaping(Result<[PhotoData]?, Error>) -> Void)
}

final class DataFetcherService: DataFetcherServiceProtocol {
    
    private let dataFetcher: DataManager?
    
    init(dataFetcher: DataManager = NetworkDataManager()) {
        self.dataFetcher = dataFetcher
    }
    
    func fetchListOfPhotos(_ complition: @escaping(Result<[PhotoData]?, Error>) -> Void) {
        let fullURL = "\(APIKeys().baseURL)/photos\(APIKeys().accessKey)"
        dataFetcher?.fetchGnericJSONData(urlString: fullURL, response: complition)
    }
    
    func fetchPhoto(withId id: String, complition: @escaping(Result<PhotoData?, Error>) -> Void) {
        let fullURL = "\(APIKeys().baseURL)/photos/\(id)\(APIKeys().accessKey)"
    }
    
}
