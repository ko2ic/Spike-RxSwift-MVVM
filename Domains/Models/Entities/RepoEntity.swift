//
//  RepoEntity.swift
//  Domains
//
//  Created by 石井幸次 on 2018/03/28.
//  Copyright © 2018年 ko2ic. All rights reserved.
//

import Foundation

public class RepoEntity: Appliable, Codable {
    public init() {
    }

    public var id: Int = 0

    public var name: String = ""

    public var fullName: String = ""

    public var stars: Int? = 0

    public var permissions: PermissionDto? = PermissionDto()

    enum CodingKeys: String, CodingKey {
        case name
        case fullName
        case stars = "stargazers_count"
    }
}
