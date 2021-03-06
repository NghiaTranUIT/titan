//
//  StackTableCell.swift
//  Titan
//
//  Created by Nghia Tran on 2/3/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa
import SwiftyPostgreSQL

protocol StackTableCellDelegate: class {
    func StackTableCellDidSelectTable(_ table: Table)
}

class StackTableCell: NSCollectionViewItem {

    //
    // MARK: - Variable
    weak var delegate: StackTableCellDelegate?
    var table: Table!
    
    //
    // MARK: - OUTLET
    @IBOutlet weak var tableTitleLbl: NSTextField!
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override var isSelected: Bool {
        didSet {
            self.tableTitleLbl.textColor = isSelected ? NSColor(hexString: "#2D2E30") : NSColor(hexString: "#8F9498")
        }
    }
    
    //
    // MARK: - Public
    func configureCell(with table: Table, isSelected: Bool = false) {
        self.table = table
        self.tableTitleLbl.stringValue = table.tableName!
        self.isSelected = isSelected
    }
    
    @IBAction func actionBtnTapped(_ sender: Any) {
        guard self.isSelected == false else {return}
        
        self.delegate?.StackTableCellDidSelectTable(self.table)
    }
    
    func minimumWidthCell(with table: Table) -> CGFloat {
        self.tableTitleLbl.stringValue = table.tableName!
        let labelSize = self.tableTitleLbl.intrinsicContentSize
        return labelSize.width + 24
    }
}

//
// MARK: - XIBInitializable
extension StackTableCell: XIBInitializable {
    typealias T = StackTableCell
}
