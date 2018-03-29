//
//  Appliable.swift
//  Domains
//
//  Created by 石井幸次 on 2018/03/29.
//  Copyright © 2018年 ko2ic. All rights reserved.
//

public protocol Appliable {}

public extension Appliable {
    public func apply(closure: (_ this: Self) -> Void) -> Self {
        closure(self)
        return self
    }
}
