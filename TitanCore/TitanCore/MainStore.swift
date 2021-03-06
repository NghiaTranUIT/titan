//
//  MainStore.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/5/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa

public enum StoreType {
    case mainStore
    case connectionStore
    case detailDatabaseStore
}

class MainStore: ReduxStore {

    //
    // MARK: - Variable
    var storyType: StoreType {
        return .mainStore
    }
    
    // Global Main Store
    static let globalStore = MainStore()
    
    //
    // MARK: - Sub store
    lazy var connectionStore: ConnectionStore = {return ConnectionStore()}()
    lazy var detailDatabaseStore: DetailDatabaseStore = {return DetailDatabaseStore()}()
    
    //
    // MARK: - Dispatch Action
    func dispatch(_ action: Action) {
        
        // Get sub store
        let subStore = self.subStoreWithType(action)
        
        // Dispatch
        subStore.handleAction(action)
    }
    
    class func dispatch(_ action: Action) {
        self.globalStore.dispatch(action)
    }
    
    func handleAction(_ action: Action) {
        
    }
}

//
// MARK: - Private
extension MainStore {
    
    // Get store with type
    func subStoreWithType(_ action: Action) -> ReduxStore {
        
        switch action.storeType {
        case .mainStore:
            return self
            
        case .detailDatabaseStore:
            return self.detailDatabaseStore
            
        case .connectionStore:
            return self.connectionStore
        }
    }
}
