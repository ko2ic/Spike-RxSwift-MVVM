//
//  TransitionEventBus.swift
//  ViewModels
//
//  Created by 石井幸次 on 2018/04/06.
//  Copyright © 2018年 ko2ic. All rights reserved.
//

import RxCocoa
import RxSwift

public class TransitionEventBus {
    private let transition: PublishRelay<TransitionType> = PublishRelay<TransitionType>()

    private var disposable: Disposable?

    public init() {}

    public func onNext(_ type: TransitionType) {
        transition.accept(type)
    }

    public func subscribe(_ onNext: @escaping (Event<TransitionType>) -> Void) {
        disposable = transition.subscribe(onNext)
    }

    public func dispose() {
        if let disposable = self.disposable {
            disposable.dispose()
            self.disposable = nil
        }
    }
}
