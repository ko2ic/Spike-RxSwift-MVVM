//
//  FirstRepository.swift
//  Domains
//
//  Created by 石井幸次 on 2018/03/30.
//  Copyright © 2018年 ko2ic. All rights reserved.
//

import RxSwift

public protocol FirstRepository {
    func fetchList() -> Single<SearchResultDto>
}
