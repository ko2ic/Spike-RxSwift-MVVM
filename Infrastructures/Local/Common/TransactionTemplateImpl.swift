//
//  TransactionTemplateImpl.swift
//  Spike-Swift-MyArchitecture
//
//  Created by ko2ic on 2016/03/25.
//  Copyright © 2016年 ko2ic. All rights reserved.
//

import Domains
import RealmSwift

public class TransactionTemplateImpl: TransactionTemplate {
    public init() {
    }

    public func execute(doProcess: () -> ()) {
        let subject = TransactionErrorState.sharedInstance.error
        do {
            let realm = try RealmWrapper.sharedInstance()
            realm.beginWrite()
            doProcess()
            try realm.commitWrite()
        } catch TransactionErrorType.lackResources {
            Logger.error("初期化失敗")
            subject.onNext(.lackResources)
        } catch RealmSwift.Realm.Error.fileAccess {
            Logger.error("commit失敗")
            subject.onNext(.lackResources)
        } catch {
            Logger.error("予期せぬエラー")
            subject.onNext(.unexpected)
        }
    }
}
