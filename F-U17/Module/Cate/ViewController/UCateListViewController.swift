//
//  UCateListViewController.swift
//  F-U17
//
//  Created by ZhouRui on 2022/2/13.
//

import UIKit
import MJRefresh
import Kingfisher

class UCateListViewController: UBaseViewController {
    
    private var searchString = ""
    private var topList = [TopModel]()
    private var rankList = [RankingModel]()
    
    private lazy var searchButton: UIButton = {
        let sb = UIButton(type: .system)
        sb.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 20, height: 30)
        sb.backgroundColor = .black.withAlphaComponent(0.1)
        sb.layer.cornerRadius = 15
        sb.setTitleColor(.white, for: .normal)
        sb.setImage(UIImage(named: "nav_search")?.withRenderingMode(.alwaysOriginal), for: .normal)
        sb.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        sb.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        sb.addTarget(self, action: #selector(searchAction), for: .touchUpInside)
        return sb
    }()
    
    private lazy var collectionView: UICollectionView = {
        let cvlayout = UICollectionViewFlowLayout()
        cvlayout.minimumInteritemSpacing = 10
        cvlayout.minimumLineSpacing = 10
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: cvlayout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.alwaysBounceVertical = true
        cv.register(cellType: URankCCell.self)
        cv.register(cellType: UTopCCell.self)
#warning ("TODO:")
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    private func loadData() {
#warning ("TODO:")
    }
    
    @objc private func searchAction() {
        navigationController?.pushViewController(UIViewController(), animated: true)
    }
    
    override func configUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(self.view.snp.edges)
        }
    }
    
    override func configNavigationBar() {
        super.configNavigationBar()
        
        navigationItem.titleView = searchButton
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    }
}

extension UCateListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return topList.prefix(3).count
        } else {
            return rankList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: UTopCCell.self)
            cell.model = topList[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: URankCCell.self)
            cell.model = rankList[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: section == 0 ? 0 : 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor(Double(UScreenWidth - 40.0) / 3.0)
        return CGSize(width: width, height: (indexPath.section == 0 ? 55 : (width * 0.75 + 30)))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let model = topList[indexPath.row]
            var titles: [String] = []
            var vcs: [UIViewController] = []
            for tab in model.extra?.tabList ?? [] {
                guard let tabTitle = tab.tabTitle else { continue }
                titles.append(tabTitle)
#warning ("TODO:")
                
            }
            let vc = UPageViewController(titles: titles, vcs: vcs, pageStyle: .topTabBar)
            vc.title = model.sortName
            navigationController?.pushViewController(vc, animated: true)
        }
        
        if indexPath.section == 1 {
            let model = rankList[indexPath.row]
#warning ("TODO:")
            
        }
    }
}
