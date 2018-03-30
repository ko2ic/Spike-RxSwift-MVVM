//
//  ApiErrorState.swift
//  RakuRakuRenrakumou
//
//  Created by 石井幸次 on 2016/10/20.
//  Copyright © 2016年 eole. All rights reserved.
//

import RxSwift

public class ApiErrorState {
    public fileprivate(set) var error = PublishSubject<HttpErrorType>()

    public static let sharedInstance = ApiErrorState()

    fileprivate init() {}
}
