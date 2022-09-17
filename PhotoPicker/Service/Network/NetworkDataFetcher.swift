//
//  NetworkDataFetcher.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 05.09.2022.
//

import Foundation

final class DataFetcherService {
    
    static let shared = DataFetcherService()
    
    private let dataManager: DataManager?
    
    private init(dataManager: DataManager = NetworkDataManager()) {
        self.dataManager = dataManager
    }
    
    func fetchListOfPhotos(_ complition: @escaping(Result<[PhotoData]?, Error>) -> Void) {
        let fullURL = "\(APIKeys().baseURL)/photos\(APIKeys().accessKey)"
        dataManager?.fetchGnericJSONData(urlString: fullURL, response: complition)
    }
    
    func fetchPhoto(withId id: String, complition: @escaping(Result<PhotoData?, Error>) -> Void) {
        let fullURL = "\(APIKeys().baseURL)/photos/\(id)\(APIKeys().accessKey)"
        dataManager?.fetchGnericJSONData(urlString: fullURL, response: complition)
    }
    
    func fetchPhoto(withQuery query: String, complition: @escaping((Result<[PhotoData]?, Error>) -> Void)) {
        let fullURL = "\(APIKeys().baseURL)/search/photos?page=1&query=\(query)\(APIKeys().accessKey)"
        dataManager?.fetchGnericJSONData(urlString: fullURL, response: complition)
    }
    
}
