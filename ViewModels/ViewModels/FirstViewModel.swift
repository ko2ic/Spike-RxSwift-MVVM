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

public class FirstViewModel: ViewModelType {
    public struct Input {
        let trigger: Driver<Void>
        let freeword: Driver<String>
        public init(trigger: Driver<Void>, freeword: Driver<String>) {
            self.trigger = trigger
            self.freeword = freeword
        }
    }

    public struct Output {
        public let items: Driver<[SectionOfCustomData]>
        public let fetching: Driver<Bool>
    }

    public let transiton = TransitionEventBus()

    public init() {}

    public func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()

        let items = Driver.combineLatest(input.trigger, input.freeword)
            .flatMapLatest { (_: Void, text: String) -> Driver<[SectionOfCustomData]> in
                if text.isEmpty {
                    return Driver.just([SectionOfCustomData]())
                }
                return self.fetchList(text)
                    .trackActivity(activityIndicator)
                    .asDriver(onErrorRecover: { error in
                        self.error(error, transition: self.transiton)
                        return Driver.empty()
                    })
            }
        return Output(items: items, fetching: activityIndicator.asDriver())
    }

    private func fetchList(_ freeword: String) -> Single<[SectionOfCustomData]> {
        let domain = FirstDomain()

        let result1 = domain.fetchList(freeword)
            .flatMap { (dto: SearchResultDto) -> Single<SectionOfCustomData> in
                Single.just(SectionOfCustomData(header: "First section", items: dto.items))
            }

        let result2 = domain.fetchList(freeword)
            .flatMap { dto -> Single<SectionOfCustomData> in
                Single.just(SectionOfCustomData(header: "Second section", items: dto.items))
            }

        return Single.zip(result1, result2, resultSelector: { (first, second) -> [SectionOfCustomData] in
            [first, second]
        })
    }
}

// MARK: - ApiErrorHandleable

extension FirstViewModel: ApiErrorHandleable {
}
