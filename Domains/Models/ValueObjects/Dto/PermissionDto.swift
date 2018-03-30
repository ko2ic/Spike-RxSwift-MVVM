//
//  PermissionDto.swift
//  Domains
//
//  Created by 石井幸次 on 2018/03/28.
//  Copyright © 2018年 ko2ic. All rights reserved.
//

import Foundation

public class PermissionDto: Codable {
    public var haveAdmin: Bool = false

    public var havePushAuthorizetion: Bool = false

    public var havePullAuthorizetion: Bool = false
}
