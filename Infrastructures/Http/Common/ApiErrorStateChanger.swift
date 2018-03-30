//
//  ApiErrorStateChanger.swift
//  Spike-Swift-MyArchitecture
//
//  Created by 石井幸次 on 2016/04/07.
//  Copyright © 2016年 ko2ic. All rights reserved.
//

public protocol ApiErrorStateChanger {

    /**
     Apiエラーの時に、ApiErrorStateを変更します。

     - parameter error: PromiseKitを使い、HttpErrorType型を想定しています。(それぞれの呼び出し元でキャストしたくないためにError型)
     */
    func change(_ error: Error)

    /**
     認証エラーの場合に呼び出す
     */
    func unauthorized()
}
