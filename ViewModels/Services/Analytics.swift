import CommonDomains
import Domains

/**
 *  GAとFirebaseとCrashlyticsに関するコードはすべてこのクラスでラップしています。
 */
public class Analytics {
    private init() {}

    /**
     didFinishLaunchingWithOptionsで呼びだすこと
     */
    public static func start() {
//        Fabric.with([Crashlytics.self()])
//
//        // defaulttrackerを設定
//        let gai = GAI.sharedInstance()
//        gai?.trackUncaughtExceptions = true
//        gai?.dispatchInterval = 5
//        gai?.logger.logLevel = GAILogLevel.error
//        let trackingId = Environment.sharedInstance.trackingId
//        _ = gai?.tracker(withTrackingId: trackingId)
//        gai?.defaultTracker.allowIDFACollection = true
    }

    /**
     エラー情報を送信する

     - parameter error:    NSError
     - parameter userInfo: NSErrorのuserInfo
     */
    public static func recordError(_ error: Error, withAdditionalUserInfo userInfo: [String: Any]? = nil) {
//        Crashlytics.sharedInstance().recordError(error, withAdditionalUserInfo: userInfo)
//        let tracker = GAI.sharedInstance().defaultTracker
//        let builder = GAIDictionaryBuilder.createException(withDescription: error.localizedDescription, withFatal: 0).build()!
//        tracker?.send(builder as Dictionary)
    }

    /**
     ログイベントを送信する。対象はGAとFirebase。

     - parameter event:    FireBaseのイベント名,GAのaction
     - parameter category: GAのcategory。FireBaseの場合はparameterになる
     - parameter label:    GAのlabel。FireBaseの場合はparameterになる
     - parameter action:   FireBaseのParamter(tapなどを想定)
     */
    public static func log(event: String, category: String, label: String, action: String?) {
//        let tracker = GAI.sharedInstance().defaultTracker
//        tracker?.send(GAIDictionaryBuilder.createEvent(withCategory: category, action: event, label: label, value: nil).build() as [NSObject: AnyObject])

//        if let value = self.convertToFirebaseEventName(gaEvent: event, gaCategory: category, gaLabel: label, fbAction: action) {
//            FIRAnalytics.logEvent(withName: value.fbEvent, parameters: value.fbParameters as [String: NSObject])
//        }
    }

    /**
     画面ページビューを送信

     - parameter screenName: 画面名
     */
    public static func send(screenName: String) {
//        let tracker = GAI.sharedInstance().defaultTracker
//        tracker?.set(kGAIScreenName, value: screenName)
//        tracker?.send(GAIDictionaryBuilder.createScreenView().build() as [NSObject: AnyObject])
    }

    /**
     firebase用に変換

     - parameter gaEvent:    イベント
     - parameter gaCategory: カテゴリ
     - parameter gaLabel:    ラベル
     - parameter fbAction:   アクション

     - returns: タプル(イベント、パラメータ)
     */
    public static func convertToFirebaseEventName(gaEvent: String, gaCategory: String, gaLabel: String, fbAction: String?) -> (fbEvent: String, fbParameters: [String: AnyHashable])? {
        if let filePath = Bundle.main.path(forResource: "Analytics", ofType: "plist") {
            let tempDict = NSDictionary(contentsOfFile: filePath)
            // event
            let dictEvent = tempDict?.object(forKey: "event") as? NSDictionary
            guard let resultEvent = dictEvent?.object(forKey: gaEvent) as? String else {
                return nil
            }

            // category
            var resultCategory = ""
            let dictCategory = tempDict?.object(forKey: "category") as? NSDictionary
            if let tempCategory = dictCategory?.object(forKey: gaCategory) as? String {
                resultCategory = tempCategory
            }

            // label
            var resultLabel = ""
            let dictLabel = tempDict?.object(forKey: "label") as? NSDictionary
            if let tempLabel = dictLabel?.object(forKey: gaLabel) as? String {
                resultLabel = tempLabel
            }

            // action
            var resultAction = ""
            if let action = fbAction {
                resultAction = action
            }

            // swift3.0からNSObjectは、AnyHashableにすること。32bit環境でクラッシュ
            let parameters: [String: AnyHashable] = [
                "category": resultCategory as AnyHashable,
                "label": resultLabel as AnyHashable,
                "action": resultAction as AnyHashable
            ]

            return (resultEvent, parameters)
        }
        return nil
    }
}
