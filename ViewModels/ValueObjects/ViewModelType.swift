//
//  ViewModelType.swift
//  ViewModels
//
//  Created by 石井幸次 on 2018/04/09.
//  Copyright © 2018年 ko2ic. All rights reserved.
//

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
