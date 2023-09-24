//
//  API.swift
//  Movie Feed
//
//  Created by DANCECOMMANDER on 20.09.2023.
//

import Foundation

struct API {
    static func configure(scheme: Scheme = .https, domain: String, version: Version = .v1 ) -> String {
        
        return [scheme.rawValue, domain, version.rawValue].joined(separator: "/")
    }
    
    enum Scheme: String {
        case http = "http:/"
        case https = "https:/"
    }
    
    enum Version: String {
        case v1
        case v2
    }
}
