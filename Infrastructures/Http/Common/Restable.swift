//
//  Restable.swift
//  Spike-Swift-MyArchitecture
//
//  Created by ko2ic on 2015/11/19.
//  Copyright © 2015年 ko2ic. All rights reserved
//

import Foundation

/**
 *  REST可能なプロトコルを表す
 */
public protocol Restable: URLRequestConvertible {
    var baseUrl: String { get }
    var path: String { get }
    var parameters: [String: Any]? { get set }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
    var headers: [String: String]? { get }
    var cachePolicy: NSURLRequest.CachePolicy { get }
    var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy { get }

    init()
    init(_ parameters: [String: Any])
}

public extension Restable {
    public func asURLRequest() throws -> URLRequest {
        let strUrl = baseUrl + path
        let component = NSURLComponents(string: strUrl)
        let request = NSMutableURLRequest(url: component!.url!)
        request.cachePolicy = self.cachePolicy
        request.httpMethod = self.method.rawValue
        request.allHTTPHeaderFields = headers
        request.setValue("application/json",
                         forHTTPHeaderField: "Content-Type")
        request.setValue("application/json",
                         forHTTPHeaderField: "Accept")
        return request as URLRequest
    }
}

public extension Restable {
    public init(_ parameters: [String: Any]) {
        self.init()
        self.parameters = parameters
    }
}

/**
 *  GET用プロトコル
 */
public protocol GetRestable: Restable {
}

public extension GetRestable {
    public var method: HTTPMethod {
        return .get
    }

    public var encoding: ParameterEncoding {
        return URLEncoding.queryString
    }
}

/**
 *  POST用プロトコル
 */
public protocol PostRestable: Restable {
}

public extension PostRestable {
    public var method: HTTPMethod {
        return .post
    }

    public var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}

/**
 *  DELETE用プロトコル
 */
public protocol DeleteRestable: Restable {
}

public extension DeleteRestable {
    public var method: HTTPMethod {
        return .delete
    }

    public var encoding: ParameterEncoding {
        return URLEncoding.queryString
    }
}
