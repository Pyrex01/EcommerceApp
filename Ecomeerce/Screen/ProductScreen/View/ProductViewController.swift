//
//  ProductViewController.swift
//  Ecomeerce
//
//  Created by Riyan Khan on 30/04/23.
//

import UIKit

class ProductViewController: UIViewController {
    
    var product:Product?
    var productViewModel = ProductViewModel()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var prodDes: UITextView!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {

        super.viewDidLoad()
        self.productName.text = product!.name!
        self.productPrice.text = "\(product!.price)"
        self.prodDes.text = product?.des
        self.productViewModel.context = self.context
        self.navigationController?.navigationBar.isHidden = true
        collectionView.backgroundColor = .systemBlue
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductImageCell.self, forCellWithReuseIdentifier: "imageCell")
        
    }


    @IBAction func addToCart(_ sender: Any) {
       let status =  productViewModel.addToCart(product: self.product!)
        switch(status){
        case .success:
            let alert = UIAlertController(title: "Alert", message: "Item added sucessfully", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            break
        case .failed:
            let alert = UIAlertController(title: "Error", message: "Failed to add Items", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            break
        }
    }

}

extension ProductViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        product!.image!.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ProductImageCell
        cell.setData(data: product!.image![indexPath.row])
        return cell
    }
    
    
}
