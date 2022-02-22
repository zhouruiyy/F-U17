//
//  UBaseTableViewHeaderFooterView.swift
//  F-U17
//
//  Created by ZhouRui on 2022/2/13.
//

import UIKit
import Reusable

class UBaseTableViewHeaderFooterView: UITableViewHeaderFooterView, Reusable {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI() {}
}
