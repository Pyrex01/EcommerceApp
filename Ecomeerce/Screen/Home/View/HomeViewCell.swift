//
//  HomeViewCell.swift
//  Ecomeerce
//
//  Created by Riyan Khan on 30/04/23.
//

import UIKit

class HomeViewCell: UITableViewCell {

    var card:HomeCard?
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var productImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(data:HomeCard){
        card = data
        self.price.text = "\(String(describing: data.price!))"
        self.name.text = data.name
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if(selected){
            backgroundColor = .darkGray
        }
        else {
            backgroundColor = .white
        }
        // Configure the view for the selected state
    }
    
}
