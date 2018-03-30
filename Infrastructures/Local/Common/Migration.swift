//
//  Migration.swift
//  RakuRen
//
//  Created by 石井幸次 on 2017/04/12.
//  Copyright © 2017年 eole. All rights reserved.
//

import RealmSwift

public class Migration {
    private init() {}

    public static func migration() {
        let config = Realm.Configuration(schemaVersion: 1, deleteRealmIfMigrationNeeded: true)
        Realm.Configuration.defaultConfiguration = config
    }

    public static func initRealmForUITests() {
        // テスト用なのでforce unwrapしています。
        let realm = try! Realm()
        realm.beginWrite()
        realm.deleteAll()
        try! realm.commitWrite()
    }
}
