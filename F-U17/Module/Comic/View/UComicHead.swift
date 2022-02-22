//
//  UComicHead.swift
//  F-U17
//
//  Created by ZhouRui on 2022/2/15.
//

import UIKit

class UComicHeadCCell: UBaseCollectionViewCell {
    
    lazy var titleLabel: UILabel = {
        let tl = UILabel()
        tl.textColor = .white
        tl.textAlignment = .center
        tl.font = .systemFont(ofSize: 14)
        return tl
    }()
    
    override func configUI() {
        layer.cornerRadius = 3
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

class UComicHead: UIView {
    private lazy var bgView: UIImageView = {
        let bv = UIImageView()
        bv.isUserInteractionEnabled = true
        bv.contentMode = .scaleAspectFill
#warning ("TODO:")
        return bv
    }()
    
    private lazy var coverView: UIImageView = {
        let cv = UIImageView()
        cv.contentMode = .scaleAspectFill
        cv.layer.cornerRadius = 3
        cv.layer.borderWidth = 1
        cv.layer.borderColor = UIColor.white.cgColor
        return cv
    }()
    
    private lazy var nameLabel: UILabel = {
        let nl = UILabel()
        nl.textColor = .white
        nl.font = .systemFont(ofSize: 16)
        return nl
    }()
    
    private lazy var authorLabel: UILabel = {
        let al = UILabel()
        al.textColor = .white
        al.font = .systemFont(ofSize: 13)
        return al
    }()
    
    private lazy var totalLabel: UILabel = {
        let tl = UILabel()
        tl.textColor = UIColor.white
        tl.font = UIFont.systemFont(ofSize: 13)
        return tl
    }()
    
    private lazy var themeView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: 40, height: 20)
        layout.scrollDirection = .horizontal
        let tv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        tv.backgroundColor = UIColor.clear
        tv.dataSource = self
        tv.showsHorizontalScrollIndicator = false
        tv.register(cellType: UComicHeadCCell.self)
        return tv
    }()
    
    private var themes: [String]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        addSubview(bgView)
        bgView.snp.makeConstraints { $0.edges.equalToSuperview() }
        bgView.addSubview(coverView)
        coverView.snp.makeConstraints {
            $0.left.bottom.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 0))
            $0.width.equalTo(90)
            $0.height.equalTo(120)
        }
        
        bgView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.left.equalTo(coverView.snp.right).offset(20)
            $0.right.greaterThanOrEqualToSuperview().offset(-20)
            $0.top.equalTo(coverView)
            $0.height.equalTo(20)
        }
        
        bgView.addSubview(authorLabel)
        authorLabel.snp.makeConstraints {
            $0.left.height.equalTo(nameLabel)
            $0.right.greaterThanOrEqualToSuperview().offset(-20)
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
        
        bgView.addSubview(totalLabel)
        totalLabel.snp.makeConstraints {
            $0.left.height.equalTo(authorLabel)
            $0.right.greaterThanOrEqualToSuperview().offset(-20)
            $0.top.equalTo(authorLabel.snp.bottom).offset(10)
        }
        
        bgView.addSubview(themeView)
        themeView.snp.makeConstraints {
            $0.left.equalTo(totalLabel)
            $0.height.equalTo(30)
            $0.right.greaterThanOrEqualToSuperview().offset(-20)
            $0.bottom.equalTo(coverView)
        }
    }
    
    var detailStatic: ComicStaticModel? {
        didSet {
            guard let detailStatic = detailStatic else {
                return
            }
            bgView.kf.setImage(urlString: detailStatic.cover, placeholder: UIImage(named: "normal_placeholder_v"))
            coverView.kf.setImage(urlString: detailStatic.cover, placeholder: UIImage(named: "normal_placeholder_v"))
            nameLabel.text = detailStatic.name
            authorLabel.text = detailStatic.author?.name
            themes = detailStatic.theme_ids
            themeView.reloadData()
        }
    }
    
    var detailRealtime: ComicRealtimeModel? {
        didSet {
            guard let detailRealtime = detailRealtime else {
                return
            }
            let text = NSMutableAttributedString(string: "点击 收藏")
            text.insert(NSAttributedString(string: "\(detailRealtime.click_total)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.orange, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]), at: 2)
            text.append(NSAttributedString(string: "\(detailRealtime.favorite_total ?? "0")", attributes: [NSAttributedString.Key.foregroundColor: UIColor.orange, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]))
            totalLabel.attributedText = text
        }
    }
}

extension UComicHead: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return themes?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: UComicHeadCCell.self)
        cell.titleLabel.text = themes?[indexPath.row]
        return cell
    }
}


