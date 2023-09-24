//
//  NetRouter.swift
//  Movie Feed
//
//  Created by DANCECOMMANDER on 20.09.2023.
//

import Foundation
import Alamofire

typealias NetWorkRouterCompletion<T> = ((AFDataResponse<T>) -> Void) where T : Decodable


protocol NetworkRouter: AnyObject {
    associatedtype EndPoint: Routing
    associatedtype ParseData: Decodable
    
    func request(_ route : EndPoint, completion: @escaping NetWorkRouterCompletion<ParseData>)
}

final class NetRouter<EndPoint: Routing, ParseData: Decodable>: NetworkRouter{
    
    func request(_ route: EndPoint, completion: @escaping NetWorkRouterCompletion<ParseData>) {
        
        AF.request(route.baseUrlWithPath,
                   method: route.method,
                   parameters: route.parameters,
                   headers: route.headers).responseDecodable(of: ParseData.self, completionHandler: completion)
    }
}
