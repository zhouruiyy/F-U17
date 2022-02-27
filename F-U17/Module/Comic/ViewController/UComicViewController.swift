//
//  UComicViewController.swift
//  F-U17
//
//  Created by ZhouRui on 2022/2/22.
//

import UIKit

protocol UComicViewWillEndDraggingDelegate: AnyObject {
    func comicWillEndDragging(_ scrollView: UIScrollView)
}

class UComicViewController: UBaseViewController {
    
    private var comicId: Int = 0
    
    private lazy var mainScrollView: UIScrollView = {
        let msv = UIScrollView()
        return msv
    }()
    
//    private lazy var detailVC
    
    
    convenience init(comicId: Int) {
        self.init()
        self.comicId = comicId
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
