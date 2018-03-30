
import Domains

/// サービスロケーターの初期化クラス
public class LocatorInitializer {
    #if UNIT_TEST
        public static var sharedInstance: LocatorInitializer!
        public init() {
        }

    #else
        public static let sharedInstance = LocatorInitializer()
        private init() {}
    #endif

    /**
     サービスロケーターをここで登録する
     */
    private var initialize: () -> Void = {
        let locator = ServiceLocatorImpl.sharedInstance
        locator.add {
            ApiErrorStateChangerImpl()
        }
        locator.add {
            TransactionTemplateImpl()
        }
        locator.add {
            FirstRepositoryImpl()
        }

        return {}
    }()

    open func setup() {
        _ = self.initialize
    }
}
