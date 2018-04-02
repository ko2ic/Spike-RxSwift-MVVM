//
//  SearchResultDto.swift
//  Domains
//
//  Created by 石井幸次 on 2018/04/02.
//  Copyright © 2018年 ko2ic. All rights reserved.
//

public class SearchResultDto: Codable {
    public init() {}

    var query = ""

    public var totalCount: Int = 0

    public var isIncompleteResults: Bool? = false

    public var items: [RepoEntity] = [RepoEntity]()

    enum CodingKeys: String, CodingKey {
        case totalCount
        case isIncompleteResults = "incomplete_results"
        case items
    }
}
