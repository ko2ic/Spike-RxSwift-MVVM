//
//  SectionOfCustomData.swift
//  Spike-RxSwift-MVVM
//
//  Created by 石井幸次 on 2018/03/28.
//  Copyright © 2018年 ko2ic. All rights reserved.
//

import Domains
import Foundation
import RxDataSources

struct SectionOfCustomData {
    var header: String
    var items: [Item]
}

extension SectionOfCustomData: SectionModelType {
    typealias Item = RepoEntity

    init(original: SectionOfCustomData, items: [Item]) {
        self = original
        self.items = items
    }
}
