//
//  ServiceLocator.swift
//  Spike-Swift-MyArchitecture
//
//  Created by 石井幸次 on 2016/04/11.
//  Copyright © 2016年 ko2ic. All rights reserved.
//

import Foundation

public protocol ServiceLocator {

    static var sharedInstance: ServiceLocator { get }

    func add<T>(_ recipe: @escaping() -> T)

    func lookup<T>() -> T
}
