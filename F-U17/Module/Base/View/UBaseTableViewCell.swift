//
//  UBaseTableViewCell.swift
//  F-U17
//
//  Created by ZhouRui on 2022/2/13.
//

import UIKit
import Reusable

class UBaseTableViewCell: UITableViewCell, Reusable {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI() {}
}
