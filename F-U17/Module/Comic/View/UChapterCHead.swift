//
//  UChapterCHead.swift
//  F-U17
//
//  Created by ZhouRui on 2022/2/14.
//

import UIKit

typealias UChapterCHeadSortClosure = (_ button: UIButton) -> Void

class UChapterCHead: UBaseCollectionReusableView {
    
    private var sortClosure: UChapterCHeadSortClosure?
    
    private lazy var chapterLabel: UILabel = {
        let cl = UILabel()
        cl.textColor = .gray
        cl.font = .systemFont(ofSize: 13)
        return cl
    }()
    
    private lazy var sortButton: UIButton = {
        let sb = UIButton()
        sb.setTitle("倒序", for: .normal)
        sb.setTitleColor(.gray, for: .normal)
        sb.titleLabel?.font = .systemFont(ofSize: 13)
        sb.addTarget(self, action: #selector(sortAction(for:)), for: .touchUpInside)
        return sb
    }()
    
    @objc private func sortAction(for button: UIButton) {
        guard let sortClosure = sortClosure else { return }
        sortClosure(button)
    }
    
    func sortClosure(_ closure: @escaping UChapterCHeadSortClosure) {
        sortClosure = closure
    }
    
    override func configUI() {
        
        addSubview(sortButton)
        sortButton.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.right.top.bottom.equalToSuperview()
            $0.width.equalTo(44)
        }
        
        addSubview(chapterLabel)
        chapterLabel.snp.makeConstraints {
            $0.left.equalTo(10)
            $0.top.bottom.equalToSuperview()
            $0.right.equalTo(sortButton.snp.left).offset(-10)
        }
    }
    
    var model: DetailStaticModel? {
        didSet {
            guard let model = model else { return }
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd"
            chapterLabel.text = "目录\(format.string(from: Date(timeIntervalSince1970: model.comic? .last_update_time ?? 0))) 更新\(model.chapter_list?.last?.name ?? "")"
        }
    }
}
