import SwiftyBeaver

public class Logger {
    public static let sharedInstance = Logger()

    private let log: SwiftyBeaver.Type

    private var isEnable = false

    private init() {
        log = SwiftyBeaver.self
        let console = ConsoleDestination()
        log.addDestination(console)
    }

    public func enable() {
        isEnable = true
    }

    public func addLogFileUrl(fileURLWithPath: String) {
        let file = FileDestination()
        file.logFileURL = URL(fileURLWithPath: fileURLWithPath)
        log.debug("filePath=" + (file.logFileURL?.absoluteString)!)
        log.addDestination(file)
    }

    public func addCloudLog(appId: String, appSecret: String, encryptionKey: String) {
        let cloud = SBPlatformDestination(
            appID: appId,
            appSecret: appSecret,
            encryptionKey: encryptionKey)
        log.addDestination(cloud)
    }

    public static func debug(_ message: @autoclosure () -> Any, _
        file: String = #file, _ function: String = #function, line: Int = #line) {
        if sharedInstance.isEnable {
            sharedInstance.log.debug(message, file, function, line: line)
        }
    }

    public static func verbose(_ message: @autoclosure () -> Any, _
        file: String = #file, _ function: String = #function, line: Int = #line) {
        if sharedInstance.isEnable {
            sharedInstance.log.verbose(message, file, function, line: line)
        }
    }

    public static func info(_ message: @autoclosure () -> Any, _
        file: String = #file, _ function: String = #function, line: Int = #line) {
        if sharedInstance.isEnable {
            sharedInstance.log.info(message, file, function, line: line)
        }
    }

    public static func warning(_ message: @autoclosure () -> Any, _
        file: String = #file, _ function: String = #function, line: Int = #line) {
        if sharedInstance.isEnable {
            sharedInstance.log.warning(message, file, function, line: line)
        }
    }

    public static func error(_ message: @autoclosure () -> Any, _
        file: String = #file, _ function: String = #function, line: Int = #line) {
        if sharedInstance.isEnable {
            sharedInstance.log.error(message, file, function, line: line)
        }
    }
}
