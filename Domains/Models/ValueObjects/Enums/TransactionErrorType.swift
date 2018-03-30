//
//  TransactionErrorType.swift
//  Spike-Swift-MyArchitecture
//
//  Created by ko2ic on 2015/11/19.
//  Copyright © 2015年 ko2ic. All rights reserved
//

import Foundation

public enum TransactionErrorType: Error {
    // 　なし
    case none
    // 予期せぬ例外。回復不能な例外。
    case unexpected
    // プログラム例外。回復不能な例外。
    case programError
    // Realmインスタンス初期化例外。
    // 一般的なディスクI/Oの処理と同様に、Realmインスタンスの作成はリソースが不足している環境下では失敗する可能性があります。実際は、各スレッドにおいて最初にRealmインスタンスを作成しようとするときだけエラーが起こる可能性があります。
    case lackResources
}
