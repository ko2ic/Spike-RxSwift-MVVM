public enum HttpErrorType: Error, CustomStringConvertible {
    // typealias RawValue = Int

    case unknown([AnyHashable: Any])
    case timeOutError([AnyHashable: Any]?) // NSURLErrorTimedOut タイムアウト　-1001
    case cannotFindHost // NSURLErrorCannotFindHost ホスト名を解決できない場合 -1003
    case cannotConnectToHost([AnyHashable: Any]?) // NSURLErrorCannotConnectToHost ホストに接続できなかった場合（ホストがダウン。Portが受け付けない状態など） -1004
    case networkConnectionLost([AnyHashable: Any]?) // NSURLErrorNetworkConnectionLost 接続してロード途中に切断した場合 -1005
    case notConnectedToInternet // NSURLErrorNotConnectedToInternet ネット接続できない状態 -1009
    case sslError([AnyHashable: Any]) // ssl系のエラー
    case statusCode(Int, [AnyHashable: Any]?)

    public enum StatusCodeType: Int {
        case none = 200
        case badRequest = 400 // パラメーター不正
        case unauthorized = 401 // 認証エラー
        case paymentRequired = 402 // 無課金エラー
        case forbidden = 403 // 認可エラー
        case notFound = 404 // not found
        case unprocessableEntity = 422 // DTDエラー
        case internalServerError = 500 // サーバーエラー
        case serviceUnavailable = 503 // メンテナンス
    }

    public var description: String {
        switch self {
        case let .statusCode(code, detail):
            return "StatudCode=\(code) Detail=\(String(describing: detail?.description))"
        case let .timeOutError(detail):
            return "timeOutError Detail=\(String(describing: detail?.description))"
        case let .cannotConnectToHost(detail):
            return "cannotConnectToHost Detail=\(String(describing: detail?.description))"
        case let .networkConnectionLost(detail):
            return "networkConnectionLost Detail=\(String(describing: detail?.description))"
        case let .sslError(detail):
            return "sslError Detail=\(String(describing: detail.description))"
        case let .unknown(detail):
            return "unknown Detail=\(String(describing: detail.description))"
        case .cannotFindHost:
            return "cannotFindHost"
        case .notConnectedToInternet:
            return "notConnectedToInternet"
        }
    }
}
