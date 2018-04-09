//
//  SectionOfCustomData.swift
//  Spike-RxSwift-MVVM
//
//  Created by 石井幸次 on 2018/03/28.
//  Copyright © 2018年 ko2ic. All rights reserved.
//

import Differentiator
import Domains
import Foundation

public struct SectionOfCustomData {
    public var header: String
    public var items: [Item]
}

extension SectionOfCustomData: SectionModelType {
    public typealias Item = RepoEntity

    public init(original: SectionOfCustomData, items: [Item]) {
        self = original
        self.items = items
    }
}
