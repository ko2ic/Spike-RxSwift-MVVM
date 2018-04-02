import Domains

public extension Restable {
    public var baseUrl: String {
        return Environment.sharedInstance.apiUrl
    }

    public var commonHeaders: [String: String]? {
        // let commonHeaders = ["Accept-Encoding": "gzip"]
        // return commonHeaders
        return nil
    }

    public var headers: [String: String]? {
        return self.commonHeaders
    }

    public var cachePolicy: NSURLRequest.CachePolicy {
        return NSURLRequest.CachePolicy.reloadIgnoringCacheData
    }

    public var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy {
        return JSONDecoder.KeyDecodingStrategy.convertFromSnakeCase
    }
}
