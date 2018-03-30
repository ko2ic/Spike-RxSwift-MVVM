//
//  FirstDomain.swift
//  Domains
//
//  Created by 石井幸次 on 2018/03/29.
//  Copyright © 2018年 ko2ic. All rights reserved.
//

import RxSwift

public class FirstDomain {
    public init() {}

    public func fetchList() -> Single<[RepoEntity]> {
        let entity1 = RepoEntity().apply {
            $0.id = 1
            $0.fullName = "fullName1"
            $0.name = "name1"
            $0.stars = 1
        }

        let entity2 = RepoEntity().apply {
            $0.id = 2
            $0.fullName = "fullName2"
            $0.name = "name2"
            $0.stars = 2
        }

        return Single.just([entity1, entity2])
    }
}
