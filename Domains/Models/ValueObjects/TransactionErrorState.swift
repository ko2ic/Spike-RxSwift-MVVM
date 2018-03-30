

import RxSwift

public class TransactionErrorState {
    public fileprivate(set) var error = PublishSubject<TransactionErrorType>()

    public static let sharedInstance = TransactionErrorState()

    fileprivate init() {}
}
