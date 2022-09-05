//
//  NetworkDataFetcher.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 05.09.2022.
//

import Foundation

protocol DataFetcherServiceProtocol {
    func fetchRandomPhoto(complition: @escaping(Result<PhotoData?, Error>) -> Void)
    func fetchPhoto(withId id: String, complition: @escaping(Result<PhotoData?, Error>) -> Void)
}

final class DataFetcherService: DataFetcherServiceProtocol {
    
    private let dataFetcher: DataManager?
    private let baseURL = "https://api.unsplash.com/"
    private let API = APIKeys()
    
    init(dataFetcher: DataManager = NetworkDataManager()) {
        self.dataFetcher = dataFetcher
    }
    
    func fetchRandomPhoto(complition: @escaping(Result<PhotoData?, Error>) -> Void) {
        let fullURL = "\(baseURL)/photos/random?client_id=\(API.accessKey)"
        dataFetcher?.fetchGnericJSONData(urlString: fullURL, response: complition)
    }
    
    func fetchPhoto(withId id: String, complition: @escaping(Result<PhotoData?, Error>) -> Void) {
        let fullURL = "\(baseURL)/photos/\(id)?client_id=\(API.accessKey)"
        dataFetcher?.fetchGnericJSONData(urlString: fullURL, response: complition)
    }
    
}
