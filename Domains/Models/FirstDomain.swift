//
//  FirstDomain.swift
//  Domains
//
//  Created by 石井幸次 on 2018/03/29.
//  Copyright © 2018年 ko2ic. All rights reserved.
//

import RxSwift

public class FirstDomain {
    fileprivate let locator: ServiceLocator!

    public init(locator: ServiceLocator = ServiceLocatorImpl.sharedInstance) {
        self.locator = locator
    }

    public func fetchList(_ freeword: String) -> Single<SearchResultDto> {
        let repository: FirstRepository = locator.lookup()

        return repository.fetchList(freeword)
    }
}
