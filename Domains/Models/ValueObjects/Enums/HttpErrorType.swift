public enum HttpErrorType: Error {
    // typealias RawValue = Int

    case none
    case unknown([AnyHashable: Any])
    case timedOutError // NSURLErrorTimedOut タイムアウト　-1001
    case cannotFindHost // NSURLErrorCannotFindHost ホスト名を解決できない場合 -1003
    case cannotConnectToHost([AnyHashable: Any]?) // NSURLErrorCannotConnectToHost ホストに接続できなかった場合（ホストがダウン。Portが受け付けない状態など） -1004
    case networkConnectionLost // NSURLErrorNetworkConnectionLost 接続してロード途中に切断した場合 -1005
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
        case internalServerError = 500 // サーバーエラー
        case serviceUnavailable = 503 // メンテナンス
        case unknown = 0
    }
}
