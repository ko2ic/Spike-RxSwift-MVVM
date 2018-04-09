//
//  ApiErrorHandleable.swift
//  Spike-RxSwift-MVVM
//
//  Created by 石井幸次 on 2018/04/06.
//  Copyright © 2018年 ko2ic. All rights reserved.
//

import Domains

public protocol ApiErrorHandleable {
    func error(_ error: Error, transition: TransitionEventBus, httpErrorClosure: (Error, TransitionEventBus) -> Void)
}

public extension ApiErrorHandleable {
    public func error(_ error: Error, transition: TransitionEventBus, httpErrorClosure: (Error, TransitionEventBus) -> Void = { error, transition in

        if error is HttpErrorType {
            let errorType = error as! HttpErrorType
            Analytics.recordError(errorType)
            switch errorType {
            case .unknown:
                transition.onNext(.alertDialogType(message: "サーバで予期せぬエラーが発生しました。しばらく待ってから再度お試しください。"))
            case .timeOutError, .cannotFindHost, .cannotConnectToHost, .networkConnectionLost, .notConnectedToInternet:
                transition.onNext(.alertDialogType(message: "通信中に接続が切れました。\n通信状況の良い場所で再度お試しください。"))
            case .sslError:
                transition.onNext(.alertDialogType(message: "SSL通信エラーが発生しました。\n安全な接続先(wifi)をご利用ください。"))
            case let .statusCode(HttpErrorType.StatusCodeType.badRequest.rawValue, detail):
                transition.onNext(.alertDialogType(message: "Bad Request. \(String(describing: detail))"))
            case let .statusCode(HttpErrorType.StatusCodeType.unprocessableEntity.rawValue, detail):
                transition.onNext(.alertDialogType(message: "Unprocessable Entity. \(String(describing: detail))"))
            case let .statusCode(code, detail):
                transition.onNext(.alertDialogType(message: "\(code). \(String(describing: detail))"))
            }
        }
    }) {
        httpErrorClosure(error, transition)
    }
}
