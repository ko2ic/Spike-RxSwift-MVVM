//
//  RealmWrapper.swift
//  Spike-Swift-MyArchitecture
//
//  Created by ko2ic on 2015/11/19.
//  Copyright © 2015年 ko2ic. All rights reserved
//

import Domains
import RealmSwift

public class RealmWrapper {
    private static var realmPerThread: Dictionary<String, Realm> = [:]

    private init() {}

    public static func sharedInstance() throws -> Realm {
        var realm = self.realmPerThread[self.threadId()]
        if realm == nil {
            do {
                realm = try Realm()
                self.realmPerThread[threadId()] = realm
            } catch let error as RealmSwift.Realm.Error {
                Logger.error("Realm init error: \(error)")
                switch error {
                case RealmSwift.Realm.Error.fileAccess:
                    throw TransactionErrorType.lackResources
                case RealmSwift.Realm.Error.fail:
                    throw TransactionErrorType.unexpected
                default:
                    throw TransactionErrorType.programError
                }
            } catch {
                Logger.error("Realm init error: unexpected")
                throw TransactionErrorType.unexpected
            }
        }
        return realm!
    }

    public static func destroy() {
        self.realmPerThread.removeValue(forKey: self.threadId())
    }

    private static func threadId() -> String {
        let id = "\(Thread.current)"
        Logger.verbose(id)
        return id
    }
}
