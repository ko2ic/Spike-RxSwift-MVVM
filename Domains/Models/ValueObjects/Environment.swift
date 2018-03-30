
import Foundation

public struct Environment {
    public static let sharedInstance = Environment()

    public let isProduct: Bool
    public let isDevelop: Bool

    // public let trackingId: String

    public let apiUrl: String

    // このメソッドはプログラムエラーの時にすぐに気づくようにクラッシュさせます。
    private init() {
//        let googlePath = Bundle.main.url(forResource: "GoogleService-Info", withExtension: "plist")
//        let googleData = try! Data(contentsOf: googlePath!)
//        let googleDict = try! PropertyListSerialization.propertyList(from: googleData, options: [], format: nil) as! [String: Any]
//        self.trackingId = googleDict["TRACKING_ID"] as! String

        let envPath = Bundle.main.url(forResource: "Environment-Info", withExtension: "plist")
        let envData = try! Data(contentsOf: envPath!)
        let envDict = try! PropertyListSerialization.propertyList(from: envData, options: [], format: nil) as! [String: Any]
        self.isProduct = envDict["isProduct"] as! Bool
        self.isDevelop = envDict["isDevelop"] as! Bool
        self.apiUrl = envDict["apiUrl"] as! String
    }
}
