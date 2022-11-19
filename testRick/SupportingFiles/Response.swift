//
//  Models.swift
//  testRick
//
//  Created by Андрей Цуркан on 16.11.2022.
//

import Foundation
struct Response: Codable {
    var results: [ResponseResult]?
}

struct ResponseResult: Codable {
    var name: String?
    var status: String?
    var species: String?
    var gender: String?
    var origin: Origin?
    var image: String?
}

struct Origin: Codable {
    var name: String?
}
