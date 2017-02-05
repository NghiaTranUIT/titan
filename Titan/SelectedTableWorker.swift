//
//  SelectedTableWorker.swift
//  Titan
//
//  Created by Nghia Tran on 2/3/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa
import TitanKit
import ReSwift

struct SelectedTableAction: Action {
    var selectedTable: Table!
    var replaceCurrentTable: Bool
}

struct AddSelectedTableToStackAction: Action {
    var selectedTable: Table!
}

class SelectedTableWorker: SyncWorker {
    
    typealias T = Void
    var seletedTable: Table!
    
    init(seletedTable: Table) {
        self.seletedTable = seletedTable
    }
    
    func execute() -> T {
    
        // If no selection -> add to stack
        var replace = false
        if mainStore.state.detailDatabaseState!.stackTables.count == 0 {
            
            // Dispatch
            replace = true
            let addStackAction = AddSelectedTableToStackAction(selectedTable: self.seletedTable)
            mainStore.dispatch(addStackAction)
        }
        
        // Select table
        let action = SelectedTableAction(selectedTable: self.seletedTable, replaceCurrentTable: true)
        mainStore.dispatch(action)
        
        // Push Changed
        NotificationManager.postNotificationOnMainThreadType(.stackTableStateChanged)
    }
}