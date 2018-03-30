//
//  TransactionTemplate.swift
//  Spike-Swift-MyArchitecture
//
//  Created by 石井幸次 on 2016/04/07.
//  Copyright © 2016年 ko2ic. All rights reserved.
//

import Foundation

/**
 *  トランザクション管理クラス
 */
public protocol TransactionTemplate {
    /**
     トランザクションを実行する

     - parameter doProcess: このブロック内がトランザクション境界になる
     */
    func execute(doProcess: () -> ())
}
