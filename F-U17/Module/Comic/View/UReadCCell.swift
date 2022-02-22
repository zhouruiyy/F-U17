//
//  UReadCCell.swift
//  F-U17
//
//  Created by ZhouRui on 2022/2/15.
//

import UIKit
import Kingfisher

extension UIImageView: Placeholder {}

class UReadCCell: UBaseCollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var placeholder: UIImageView = {
        let ph = UIImageView(image: UIImage(named: "yaofan"))
        ph.contentMode = .center
        return ph
    }()
    
    override func configUI() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints{ $0.edges.equalToSuperview() }
    }
    
    var model: ImageModel? {
        didSet {
            guard let model = model else { return }
            imageView.image = nil
            imageView.kf.setImage(urlString: model.location, placeholder: placeholder)
        }
    }
    
}
