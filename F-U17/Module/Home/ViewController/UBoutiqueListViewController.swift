//
//  UBoutiqueListViewController.swift
//  F-U17
//
//  Created by ZhouRui on 2022/2/26.
//

import UIKit
import LLCycleScrollView

class UBoutiqueListViewController: UBaseViewController, UICollectionViewDelegate {
    
    private var sexType: Int = UserDefaults.standard.integer(forKey: String.sexTypeKey)
    private var galleryItems = [GalleryItemModel]()
    private var textItems = [TextItemModel]()
    private var comicLists = [ComicListModel]()
    
    private lazy var bannerView: LLCycleScrollView = {
        let bv = LLCycleScrollView()
        bv.backgroundColor = UIColor.background
        bv.autoScrollTimeInterval = 6
        bv.placeHolderImage = UIImage(named: "normal_placeholder")
        bv.coverImage = UIImage()
        bv.pageControlPosition = .right
        bv.pageControlBottom = 20
        bv.titleBackgroundColor = .clear
        bv.lldidSelectItemAtIndex = didSelectBanner(index:)
        return bv
    }()
    
    private lazy var sexTypeButton: UIButton = {
        let sb = UIButton()
        sb.setTitleColor(.black, for: .normal)
        sb.addTarget(self, action: #selector(changeSex), for: .touchUpInside)
        return sb
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UCollectionViewSectionBackgroundLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.background
        cv.delegate = self
        cv.dataSource = self
        cv.alwaysBounceVertical = true
        cv.contentInset = UIEdgeInsets(top: UScreenWidth * 0.467, left: 0, bottom: 0, right: 0)
        cv.scrollIndicatorInsets = cv.contentInset
        cv.register(cellType: UComicCCell.self)
        cv.register(cellType: UBoardCCell.self)
        cv.register(supplementaryViewType: UComicCHead.self, ofKind: UICollectionView.elementKindSectionHeader)
        cv.register(supplementaryViewType: UComicCFoot.self, ofKind: UICollectionView.elementKindSectionFooter)
        cv.uHead = URefreshHeader { [weak self] in self?.loadData(false)}
        cv.uFoot = URefreshDiscoverFooter()
//        cv.uempty = UEmptyView(verticalOffset: -(cw.contentInset.top)) { self.loadData(false) }
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData(false)
    }
    
    
    @objc func changeSex() {
        loadData(true)
    }
    
    private func didSelectBanner(index: Int) {
        guard index < galleryItems.count else { return }
        
        let item = galleryItems[index]
        if item.linkType == 2 {
            guard let url = item.ext?.compactMap({return $0.key == "url" ? $0.val : nil}).joined() else { return }
            let vc = UWebViewController(url: url)
            navigationController?.pushViewController(vc, animated: true)
        } else {
            guard let comicIdString = item.ext?.compactMap({return $0.key == "comicId" ? $0.val : nil}).joined(), let comicId = Int(comicIdString) else { return }
            let vc = UComicViewController(comicId: comicId)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func loadData(_ changeSex: Bool) {
        if changeSex {
            sexType = 3 - sexType
            UserDefaults.standard.set(sexType, forKey: String.sexTypeKey)
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: .USexTypeDidChange, object: nil)
        }
        
        ApiLoadingProvider.request(UApi.boutiqueList(sexType: sexType), model: BoutiqueListModel.self) {
            [weak self] (responseData) in
            self?.galleryItems = responseData?.galleryItems ?? []
            self?.textItems = responseData?.textItems ?? []
            self?.comicLists = responseData?.comicLists ?? []
            
            self?.sexTypeButton.setImage(UIImage(named: self?.sexType == 1 ? "gender_male" : "gender_female"),
                                         for: .normal)
            
            self?.collectionView.uHead?.endRefreshing()
//            self?.collectionView.uempty?.allowShow = true
            
            self?.collectionView.reloadData()
            self?.bannerView.imagePaths = self?.galleryItems.compactMap{ $0.cover } ?? []
        }
    }
    
    override func configUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(bannerView)
        bannerView.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(collectionView.contentInset.top)
        }
        
        view.addSubview(sexTypeButton)
        sexTypeButton.snp.makeConstraints {
            $0.width.height.equalTo(60)
            $0.bottom.equalToSuperview().offset(-20)
            $0.right.equalToSuperview()
        }
    }
}

extension UBoutiqueListViewController: UCollectionViewSectionBackgroundLayoutDelegateLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return comicLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, backgroundColorForSectionAt section: Int) -> UIColor {
        return UIColor.white
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let comicList = comicLists[section]
        return comicList.comics?.prefix(4).count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let head = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath, viewType: UComicCHead.self)
            let comicList = comicLists[indexPath.section]
            head.iconView.kf.setImage(urlString: comicList.newTitleIconUrl)
            head.titleLabel.text = comicList.itemTitle
            head.moreActionClosure { [weak self] in
                if comicList.comicType == .thematic {
                    let vc = UPageViewController(titles: ["漫画",
                                                          "次元"],
                                                 vcs: [USpecialViewController(argCon: 2),
                                                       USpecialViewController(argCon: 4)],
                                                 pageStyle: .navigationBarSegment)
                    self?.navigationController?.pushViewController(vc, animated: true)
                } else if comicList.comicType == .animation {
                    let vc = UWebViewController(url: "http://m.u17.com/wap/cartoon/list")
                    vc.title = "动画"
                    self?.navigationController?.pushViewController(vc, animated: true)
                } else if comicList.comicType == .update {
//                    let vc = UUpdateListViewController(argCon: comicList.argCon,
//                                                      argName: comicList.argName,
//                                                      argValue: comicList.argValue)
//                    vc.title = comicList.itemTitle
//                    self?.navigationController?.pushViewController(vc, animated: true)
                } else {
//                    let vc = UComicListViewController(argCon: comicList.argCon,
//                                                      argName: comicList.argName,
//                                                      argValue: comicList.argValue)
//                    vc.title = comicList.itemTitle
//                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
            return head
        } else {
            let foot = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, for: indexPath, viewType: UComicCFoot.self)
            return foot
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let comicList = comicLists[section]
        return comicList.itemTitle?.count ?? 0 > 0 ? CGSize(width: UScreenWidth, height: 44) : CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return comicLists.count - 1 != section ? CGSize(width: UScreenWidth, height: 10) : CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let comicList = comicLists[indexPath.section]
        if comicList.comicType == .billboard {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: UBoardCCell.self)
            cell.model = comicList.comics?[indexPath.row]
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: UComicCCell.self)
            if comicList.comicType == .thematic {
                cell.style = .none
            } else {
                cell.style = .withTitieAndDesc
            }
            cell.model = comicList.comics?[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let comicList = comicLists[indexPath.section]
        if comicList.comicType == .billboard {
            let width = floor((UScreenWidth - 15.0) / 4.0)
            return CGSize(width: width, height: 80)
        }else {
            if comicList.comicType == .thematic {
                let width = floor((UScreenWidth - 5.0) / 2.0)
                return CGSize(width: width, height: 120)
            } else {
                let count = comicList.comics?.takeMax(4).count ?? 0
                let warp = count % 2 + 2
                let width = floor((UScreenWidth - CGFloat(warp - 1) * 5.0) / CGFloat(warp))
                return CGSize(width: width, height: CGFloat(warp * 80))
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let comicList = comicLists[indexPath.section]
        guard let item = comicList.comics?[indexPath.row] else { return }
        
        if comicList.comicType == .billboard {
//            let vc = UComicListViewController(argName: item.argName,
//                                              argValue: item.argValue)
//            vc.title = item.name
//            navigationController?.pushViewController(vc, animated: true)
        } else {
            if item.linkType == 2 {
                guard let url = item.ext?.compactMap({ return $0.key == "url" ? $0.val : nil }).joined() else { return }
                let vc = UWebViewController(url: url)
                navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc = UComicViewController(comicId: item.comicId)
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            bannerView.snp.updateConstraints{ $0.top.equalToSuperview().offset(min(0, -(scrollView.contentOffset.y + scrollView.contentInset.top))) }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            UIView.animate(withDuration: 0.5, animations: {
                self.sexTypeButton.transform = CGAffineTransform(translationX: 50, y: 0)
            })
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            UIView.animate(withDuration: 0.5, animations: {
                self.sexTypeButton.transform = CGAffineTransform.identity
            })
        }
    }
}
