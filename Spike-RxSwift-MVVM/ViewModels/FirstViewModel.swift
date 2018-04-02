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
        let domain = FirstDomain()

        let result1 = domain.fetchList()
            .flatMap { (dto: SearchResultDto) -> Single<SectionOfCustomData> in
                Single.just(SectionOfCustomData(header: "First section", items: dto.items))
            }

        let result2 = domain.fetchList()
            .flatMap { dto -> Single<SectionOfCustomData> in
                Single.just(SectionOfCustomData(header: "Second section", items: dto.items))
            }

        return Single.zip(result1, result2, resultSelector: { (first, second) -> [SectionOfCustomData] in
            [first, second]
        })
    }
}
