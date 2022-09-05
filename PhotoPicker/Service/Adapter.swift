//
//  Adapter.swift
//  PhotoPicker
//
//  Created by Илья Шаповалов on 05.09.2022.
//

import Foundation

protocol AdapterProtocol {
    
}

final class Adapter: AdapterProtocol {
    
    private let dataFetcher: DataFetcherServiceProtocol?
    
    init(dataFetcher: DataFetcherServiceProtocol = DataFetcherService()) {
        self.dataFetcher = dataFetcher
    }
    
    func getRandomPhoto(complition: @escaping(Result<PhotoModel, Error>) -> Void) {
        dataFetcher?.fetchRandomPhoto(complition: { result in
            switch result {
            case .failure(let error):
                complition(.failure(error))
            case .success(let decodedPhoto):
                guard let photo = decodedPhoto else { return }
                
            }
        })
    }
    
}
