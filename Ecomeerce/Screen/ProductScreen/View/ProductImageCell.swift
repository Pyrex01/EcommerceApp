//
//  ProductImageCell.swift
//  Ecomeerce
//
//  Created by Riyan Khan on 01/05/23.
//

import UIKit
import Kingfisher

class ProductImageCell: UICollectionViewCell {

    var productImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        productImage = UIImageView(frame: bounds)
        productImage.contentMode = .scaleToFill
        productImage.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(productImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(data:String){
        productImage.image = Common.image(from: data)
    }
    
}
