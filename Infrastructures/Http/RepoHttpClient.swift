//
//  RepoHttpClient.swift
//  Infrastructures
//
//  Created by 石井幸次 on 2018/03/30.
//  Copyright © 2018年 ko2ic. All rights reserved.
//

import Domains
import RxSwift

class RepoHttpClient {
    static let sharedInstance = RepoHttpClient()

    fileprivate init() {}

    func fetchList() -> Single<[RepoEntity]> {
        let api = ApiCaller.sharedInstance
        let single: Single<[RepoEntity]> = api.list(FetchContext(["q": "ko2ic", "page": 1]))
        return single
    }
}

private final class FetchContext: GetRestable {
    var parameters: [String: Any]?

    required init(parameters: [String: Any]) {
        self.parameters = parameters
    }

    internal init() {
    }

    var path: String {
        return "/search/repositories"
    }
}
