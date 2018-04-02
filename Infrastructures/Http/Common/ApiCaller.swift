//
//  ApiCaller.swift
//  Spike-Swift-MyArchitecture
//
//  Created by 石井幸次 on 2016/03/30.
//  Copyright © 2016年 ko2ic. All rights reserved.
//

import Domains
import RxSwift

/// API呼び出しクラス
public class ApiCaller {
    public static let sharedInstance = ApiCaller()

    fileprivate init() {}

    /**
     結果がリスト以外のAPIを呼び出す

     - parameter context: コンテキスト

     - returns: プロミス
     */
    public func call<T>(_ context: Restable) -> Single<T> where T: Codable {
        var request = try! context.encoding.encode(context, with: context.parameters)
        request.httpMethod = context.method.rawValue
        return response(request) { data -> T in
            let decorder = JSONDecoder()
            decorder.keyDecodingStrategy = context.keyDecodingStrategy
            return try decorder.decode(T.self, from: data)
        }.subscribeOn(ConcurrentMainScheduler.instance)
    }

    /**
     結果がリストのAPIを呼び出す

     - parameter context: コンテキスト

     - returns: プロミス
     */
    public func list<T>(_ context: Restable) -> Single<[T]> where T: Codable {
        var request = try! context.encoding.encode(context, with: context.parameters)
        request.httpMethod = "GET"
        return response(request) { data -> [T] in
            let decorder = JSONDecoder()
            decorder.keyDecodingStrategy = context.keyDecodingStrategy
            return try decorder.decode([T].self, from: data)
        }
    }

    // MARK: - private method

    private func response<R>(_ request: URLRequest, convert: @escaping (Data) throws -> R) -> Single<R> {
        return Observable.create { observer in
            let config = URLSessionConfiguration.default
            config.timeoutIntervalForRequest = 20
            let session = URLSession(configuration: config, delegate: nil, delegateQueue: OperationQueue.main)
            let task = session.dataTask(with: request) { data, response, error in
                Logger.info("\n-------------------------api start-------------------------")
                Logger.info("url = " + (request.url?.absoluteString)!)
                Logger.info("method = " + request.httpMethod!)
                if let requestBody = request.httpBody, let requestBodyLog = NSString(data: requestBody, encoding: String.Encoding.utf8.rawValue) {
                    Logger.info("requestBody = \(requestBodyLog)")
                }
                if let headers = request.allHTTPHeaderFields {
                    Logger.info("header = \(headers.debugDescription))")
                }

                if let nsError = error {
                    Logger.error("api結果: 失敗: ")
                    Logger.error(error!)

                    if nsError._code == NSURLErrorTimedOut {
                        observer.on(.error(HttpErrorType.timedOutError))
                    } else if nsError._code == NSURLErrorCannotFindHost {
                        observer.on(.error(HttpErrorType.cannotFindHost))
                    } else if nsError._code == NSURLErrorCannotConnectToHost {
                        observer.on(.error(HttpErrorType.cannotConnectToHost(nsError._userInfo as? [AnyHashable: Any])))
                    } else if nsError._code == NSURLErrorNetworkConnectionLost {
                        observer.on(.error(HttpErrorType.networkConnectionLost))
                    } else if nsError._code == NSURLErrorNotConnectedToInternet {
                        observer.on(.error(HttpErrorType.notConnectedToInternet))
                    } else if nsError._code == NSURLErrorSecureConnectionFailed || nsError._code == NSURLErrorServerCertificateHasBadDate || nsError._code == NSURLErrorServerCertificateUntrusted || nsError._code == NSURLErrorServerCertificateHasUnknownRoot || nsError._code == NSURLErrorServerCertificateNotYetValid || nsError._code == NSURLErrorClientCertificateRejected || nsError._code == NSURLErrorClientCertificateRequired || nsError._code == NSURLErrorClientCertificateRequired || nsError._code == NSURLErrorCannotLoadFromNetwork {
                        if let userInfo = nsError._userInfo as? [AnyHashable: Any] {
                            observer.on(.error(HttpErrorType.sslError(userInfo)))
                        } else {
                            observer.on(.error(HttpErrorType.sslError(["error_code": nsError._code])))
                        }
                    } else {
                        if let userInfo = nsError._userInfo as? [AnyHashable: Any] {
                            observer.on(.error(HttpErrorType.unknown(userInfo)))
                        } else {
                            observer.on(.error(HttpErrorType.unknown(["error_code": nsError._code])))
                        }
                    }
                    Logger.info("\n-------------------------api end---------------------------")
                    return
                }
                if let data = data {
                    let responseString = String(data: data, encoding: .utf8)
                    Logger.info("responseBody = \n" + responseString!)
                    if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                        Logger.info("statudCode=\(statusCode)")
                        if 400...599 ~= statusCode {
                            Logger.error("Httpステータスコードエラー")

                            var detail: [AnyHashable: Any]?
                            do {
                                detail = try JSONSerialization.jsonObject(with: data, options: []) as? [AnyHashable: Any]
                            } catch {
                            }
                            observer.on(.error(HttpErrorType.statusCode(statusCode, detail)))
                            Logger.info("\n-------------------------api end---------------------------")
                            return
                        }
                    }

                    do {
                        let result = try convert(data)
                        observer.on(.next(result))
                    } catch {
                        observer.on(.error(HttpErrorType.unknown(["jsonパースエラー": error])))
                    }
                }
                observer.on(.completed)
                Logger.info("\n-------------------------api end---------------------------")
            }
            task.resume()
            return Disposables.create(with: task.cancel)
        }.asSingle()
    }

    private class func createBody(with fileDto: FileUploadDto, boundary: String) -> Data {
        var body = Data()
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"\(fileDto.name)\"; filename=\"\(fileDto.fileName)\"\r\n")
        body.append("Content-Type: \(fileDto.type.rawValue)\r\n\r\n")
        body.append(fileDto.fileData)
        body.append("\r\n")
        body.append("--\(boundary)--\r\n")
        return body
    }
}

fileprivate extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
