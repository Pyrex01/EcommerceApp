//
//  CartTableViewCell.swift
//  Ecomeerce
//
//  Created by Riyan Khan on 30/04/23.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    var cart:Cart?
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var cartImageView: UIImageView!
    @IBOutlet weak var productCount: UILabel!
    
    var cartItem:CartItem?
    var minusHandler: ((Cart)->Void)?
    var plusHandler: ((Cart)->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(data:CartItem){
        self.cartItem = data
        self.productName.text = cartItem!.name
        self.productPrice.text = "\(cartItem!.price! * cartItem!.count!)"
        self.productCount.text = "\(String(describing: cartItem!.count!))"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if(selected){
            self.backgroundColor = .darkGray
        }else {
            self.backgroundColor = .white
        }
        // Configure the view for the selected state
    }
    
    @IBAction func minusCount(_ sender: Any) {
        let newCount = Int(self.productCount.text!)! - 1
        
        minusHandler?(self.cart!)
    }
    @IBAction func addCount(_ sender: Any) {
        plusHandler?(self.cart!)
    }
}
