import MobileCoreServices

/**
 画像Mimeタイプ（Mime: Multipurpose Internet Mail Extensions）
 */
public enum MimeType: String {
    case jpeg = "image/jpeg"
    case png = "image/png"
    case gif = "image/gif"
    case other = "application/octet-stream"

    /**
     ファイルパスからファイルタイプ取得する

     - parameter path: ファイルパス

     - returns: ファイルタイプ
     */
    public static func mimeType(for urlPath: URL) -> MimeType {
        let pathExtension = urlPath.pathExtension
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as CFString, nil)?.takeRetainedValue() {
            if let mimeType = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                if let result = MimeType(rawValue: mimeType as String) {
                    return result
                }
            }
        }
        return .other
    }
}
