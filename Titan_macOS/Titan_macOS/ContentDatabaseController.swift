//
//  ContentDatabaseController.swift
//  Titan_macOS
//
//  Created by Nghia Tran on 4/19/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import TitanCore
import SnapKit

class ContentDatabaseController: BaseViewController {

    //
    // MARK: - OUTLET
    @IBOutlet weak var containerStackView: NSView!
    @IBOutlet weak var containerGridView: NSView!
    
    
    //
    // MARK: - Variable
    fileprivate var viewModel: ContentDatabaseViewModel!
    
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initCommon()
        self.initDataSource()
        self.initViewModel()
        self.binding()
    }
    
}

//
// MARK: - Private
extension ContentDatabaseController {
    
    fileprivate func initCommon() {
        
    }
    
    fileprivate func initDataSource() {
    }
    
    fileprivate func initViewModel() {
        self.viewModel = ContentDatabaseViewModel()
    }
    
    fileprivate func binding() {
        
        // Reload
        self.viewModel.output.selectedGridTableChangedDriver.drive(onNext: { gridView in
            
            // Remove all
            for view in self.viewModel.output.gridDatabaseViewVariable.value {
                view.removeFromSuperview()
            }
            
            // Add 
            guard let gridView = gridView else {return}
            gridView.snp.makeConstraints({ (make) in
                make.edges.equalTo(self.containerGridView)
            })
            
        }).addDisposableTo(self.disposeBase)
    }
}
