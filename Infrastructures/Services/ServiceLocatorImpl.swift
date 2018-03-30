//
//  ServiceLocatorImpl.swift
//  Spike-Swift-MyArchitecture
//
//  Created by 石井幸次 on 2016/04/02.
//  Copyright © 2016年 ko2ic. All rights reserved.
//

import Foundation

public class ServiceLocatorImpl: ServiceLocator {

    fileprivate lazy var container: Dictionary < String, () -> Any > = [:]

    fileprivate static let singleton = ServiceLocatorImpl()

    public static var sharedInstance: ServiceLocator { return singleton }

    fileprivate init() {
    }

    /**
     追加する

     - parameter recipe: 登録対象のオブジェクト
     */
    public func add<T>(_ recipe: @escaping () -> T) {
        let key = typeName(T.self)
        container[key] = recipe
    }

    /**
     オブジェクトを取得する

     - returns:オブジェクト
     */
    public func lookup<T>() -> T {
        let key = typeName(T.self)
        guard let result = container[key] else {
            // 何故かこうしないと取得できない場合がある
            let result = container.filter { tempKey, _ in
                tempKey == key
            }.first?.value
            return result!() as! T
        }
        return result() as! T
    }

    fileprivate func typeName<T>(_ some: T.Type) -> String {
        // 命名規約で動作
        return "\(some)".replacingOccurrences(of: "Impl", with: "")
    }
}
