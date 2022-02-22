//
//  UReadBottomBar.swift
//  F-U17
//
//  Created by ZhouRui on 2022/2/15.
//

import UIKit
import SnapKitExtend

class UReadBottomBar: UIView {
    
    lazy var menuSlider: UISlider = {
        let ms = UISlider()
        ms.thumbTintColor = UIColor.theme
        ms.minimumTrackTintColor = UIColor.theme
        ms.isContinuous = false
        return ms
    }()
    
    lazy var deviceDirectionButton: UIButton = {
        let db = UIButton(type: .system)
        db.setImage(UIImage(named: "readerMenu_changeScreen_horizontal")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return db
    }()
    
    lazy var lightButton: UIButton = {
        let lb = UIButton(type: .system)
        lb.setImage(UIImage(named: "readerMenu_luminance")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return lb
    }()
    
    lazy var chapterButton: UIButton = {
        let cb = UIButton(type: .system)
        cb.setImage(UIImage(named: "readerMenu_catalog")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return cb
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        addSubview(menuSlider)
        menuSlider.snp.makeConstraints {
            $0.left.right.top.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 40, bottom: 10, right: 40))
            $0.height.equalTo(30)
            
        }
        
        addSubview(deviceDirectionButton)
        addSubview(lightButton)
        addSubview(chapterButton)
        
        let buttonArray = [deviceDirectionButton, lightButton, chapterButton]
        buttonArray.snp.distributeViewsAlong(axisType: .horizontal, fixedItemLength: 60, leadSpacing: 40, tailSpacing: 40)
        buttonArray.snp.makeConstraints {
            $0.top.equalTo(menuSlider.snp.bottom).offset(10)
            $0.bottom.equalToSuperview()
        }
    }
    

}
