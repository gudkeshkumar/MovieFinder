//
//  ServiceProvider.swift
//  MovieFinder
//
//  Created by apple on 05/04/21.
//

import Foundation

class RemoteServiceProvider<T: APIService> {
    private var urlSession: URLSession

    init(_ urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func load<U>(service: T, decodeType: U.Type, completion: @escaping (Result<U, Error>) -> Void) where U: Decodable {
        call(service.urlRequest) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let resp = try decoder.decode(decodeType, from: data)
                    DispatchQueue.main.async {
                        completion(.success(resp))
                    }
                }
                catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            
            }
        }
    }
}

extension RemoteServiceProvider {
    private func call(_ request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        urlSession.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            }
        }.resume()
    }
}
