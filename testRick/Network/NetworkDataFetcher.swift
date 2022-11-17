//
//  NetworkDataFetcher.swift
//  testRick
//
//  Created by Андрей Цуркан on 16.11.2022.
//

import Foundation


class NetworkDataFetcher {
   private let networkService = NetworkService()
    
    func fetchJson(urlString: String, closure: @escaping ([ResponseResult]?) ->Void) {
        networkService.request(urlString: urlString) { result in
            switch result {
            case.success(let data):
                do {
                    let response = try JSONDecoder().decode(Response.self, from: data)
                    closure(response.results)
                } catch let jsonError {
                    print("Failied to Docode", jsonError)
                    closure(nil)
                }
            case.failure(let error):
                print("SYSTEM ERROR\(error.localizedDescription)")
                closure(nil)
            }
        }
    }
}
