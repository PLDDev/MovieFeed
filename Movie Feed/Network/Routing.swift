//
//  Routing.swift
//  Movie Feed
//
//  Created by DANCECOMMANDER on 20.09.2023.
//

import Foundation
import Alamofire

protocol Routing {
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters { get }
    var headers: HTTPHeaders { get }
    var baseUrlWithPath: String { get }
}

extension Routing {
    var method: HTTPMethod { return .get }
    var parameters: Parameters { return [:] }
    var headers: HTTPHeaders { return [:] }
    var baseUrlWithPath: String { return baseUrl + path }
}
