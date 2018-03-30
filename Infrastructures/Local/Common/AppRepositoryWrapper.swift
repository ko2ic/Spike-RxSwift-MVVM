//
//  AppRepositoryWrapper.swift
//  Spike-Swift-MyArchitecture
//
//  Created by ko2ic on 2015/11/19.
//  Copyright © 2015年 ko2ic. All rights reserved.
//

import RealmSwift

class AppRepositoryWrapper<T: Object>: AppRepository {

    private let saveClosure: (T) -> ()
    private let findClosure: () -> Results<T>?
    private let deleteAllClosure: () -> ()
    private let deleteClosure: (T) -> ()

    init < R: AppRepository> (_ repository: R) where R.T == T {
        self.saveClosure = repository.save
        self.findClosure = repository.find
        self.deleteAllClosure = repository.deleteAll
        self.deleteClosure = repository.delete
    }

    func save(_ entity: T) {
        self.saveClosure(entity)
    }

    func find() -> Results<T>? {
        return self.findClosure()
    }

    func deleteAll() {
        self.deleteAllClosure()
    }

    func delete(_ entity: (T)) {
        self.delete(entity)
    }
}
