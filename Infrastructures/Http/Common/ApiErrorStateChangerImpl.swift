//
//  ApiErrorStateChangerImpl.swift
//  Spike-Swift-MyArchitecture
//
//  Created by ko2ic on 2016/03/25.
//  Copyright © 2016年 ko2ic. All rights reserved.
//

import Domains

public class ApiErrorStateChangerImpl: ApiErrorStateChanger {
    public init() {
    }

    /**
     ApiErrorStateを変更する。このメソッドはAPIでエラーがあった場合に利用する。
     (ApiCallerからのPromiseのcatch句でerrorが渡される前提)

     - parameter error: Apiエラー情報
     */
    public func change(_ error: Error) {
        let subject = ApiErrorState.sharedInstance.error
        // ApiCallerからのPromiseのcatch句でerrorが渡される前提です
        if error is HttpErrorType {
            let errorType = error as! HttpErrorType
            subject.onNext(errorType)
        } else {
            // objective-cの古いコード用
            let nsError = error as NSError
            let code = nsError.code
            switch code {
            case 400...599:
                subject.onNext(.statusCode(code, nsError.userInfo))
            case -1001:
                subject.onNext(.timedOutError)
            case -1003:
                subject.onNext(.cannotFindHost)
            case -1004:
                subject.onNext(.cannotConnectToHost(nsError.userInfo))
            case -1005:
                subject.onNext(.networkConnectionLost)
            case -1009:
                subject.onNext(.notConnectedToInternet)
            default:
                subject.onNext(.unknown(nsError.userInfo))
                break
            }
        }
    }

    /**
     認証エラーの場合にApiErrorStateを変更する
     */
    public func unauthorized() {
        // 本来は必要ないメソッドだが、APIの設計が何故かuserIdを必要としているため（アクセストークンがあるので本来はユーザIDはAPI呼び出しで必要ない）
        let subject = ApiErrorState.sharedInstance.error
        subject.onNext(.statusCode(HttpErrorType.StatusCodeType.unauthorized.rawValue, nil))
    }
}
