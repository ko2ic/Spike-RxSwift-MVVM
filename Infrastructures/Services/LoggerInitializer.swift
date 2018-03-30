import Domains

public class LoggerInitializer {
    #if UNIT_TEST
        public static var sharedInstance: LoggerInitializer!
        public init() {
        }

    #else
        public static let sharedInstance = LoggerInitializer()
        private init() {}
    #endif

    private lazy var initializer: () -> () = {
        if Environment.sharedInstance.isDevelop {
            Logger.sharedInstance.enable()
            Logger.sharedInstance.addLogFileUrl(fileURLWithPath: "/tmp/swiftybeaver.log")
            // Logger.sharedInstance.addCloudLog(appId: "<TODO>", appSecret: "<TODO>", encryptionKey: "<TODO>")
        }
        return {}
    }()

    open func setup() {
        _ = self.initializer
    }
}

// リリースで表示されないようにオーバーライド
func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    if !Environment.sharedInstance.isProduct {
        Swift.print(items, separator: separator, terminator: terminator)
    }
}

func print<Target: TextOutputStream>(_ items: Any..., separator: String = " ", terminator: String = "\n", to output: inout Target) {
    if !Environment.sharedInstance.isProduct {
        Swift.print(items, separator: separator, terminator: terminator)
    }
}

func NSLog(_ format: String, _ args: CVarArg...) {
    if !Environment.sharedInstance.isProduct {
        Foundation.NSLog(String(format: format, arguments: args))
    }
}
