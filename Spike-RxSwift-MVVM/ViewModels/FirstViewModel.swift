//
//  FirstViewModel.swift
//  Spike-RxSwift-MVVM
//
//  Created by 石井幸次 on 2018/03/28.
//  Copyright © 2018年 ko2ic. All rights reserved.
//

import Domains
import Foundation
import RxCocoa
import RxSwift

class FirstViewModel {
    func fetchList() -> Single<[SectionOfCustomData]> {
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

        let sections = [
            SectionOfCustomData(header: "First section", items: [entity1, entity2]),
            SectionOfCustomData(header: "Second section", items: [entity1, entity2]),
        ]
        return Single.just(sections)
    }
}
