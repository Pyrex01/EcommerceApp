//
//  CartTableViewController.swift
//  Ecomeerce
//
//  Created by Riyan Khan on 30/04/23.
//

import UIKit

class CartTableViewController: UITableViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var refresher = UIRefreshControl()
    var cartViewModel = CartViewModel()
    
    let button = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.addSubview(refresher)
        view.backgroundColor = .white
        configureViewModel()
        configureTable()
        configureOrderButton()
    }
    
    func configureOrderButton(){
        button.setTitle("Order", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.frame = CGRect(x: view.bounds.width - 100, y: view.bounds.height - 100, width: 70, height: 50)
        button.center = CGPoint(x: view.bounds.midX + 100, y: view.bounds.maxY - 25 )
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = CGFloat(floatLiteral: 25)
        view.addSubview(button)
    }
    
    @objc func buttonTapped(){
        print("making oreder")
        let status = cartViewModel.makeOrder()
        switch(status){
        case .sucess:
            let alert = UIAlertController(title: "Alert", message: "Order Place Sucessfuly", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            break
        case .fail:
            let alert = UIAlertController(title: "Alert", message: "something went wrong", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            break
        case .insufficient:
            let alert = UIAlertController(title: "Alert", message: "Item not available", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            break
        }
        cartViewModel.fetch()
        tableView.reloadData()
    }

    func configureViewModel(){
        cartViewModel.context = self.context
        
        cartViewModel.fetchHandle = {
            self.tableView.reloadData()
        }
        
        cartViewModel.fetch()
    }
    
    func configureTable(){
        tableView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCellId")
        tableView.rowHeight = CGFloat(133)
        refresher.addTarget(self, action: #selector(refreshTable), for: .valueChanged )
        tableView.contentInset = UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 0)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cartViewModel.carts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCellId",for: indexPath) as! CartTableViewCell
        let cart = cartViewModel.carts[indexPath.row]
        
        let product = cart.product
        var cartItem = CartItem()
        cartItem.count = Int(cart.count)
        cartItem.price = Int(product!.price)
        cartItem.name = product?.name
        cell.cart = cart
        cell.setData(data: cartItem )
        cell.cartImageView.image = Common.image(from: product!.image![0])
        
        cell.plusHandler = {
            cart in
            self.cartViewModel.addCount(cart: cart)
            self.cartViewModel.fetch()
            self.tableView.reloadData()
        }
        
        cell.minusHandler = {
            cart in
            self.cartViewModel.minusCount(cart: cart)
            self.cartViewModel.fetch()
            self.tableView.reloadData()
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let prodViewController = ProductViewController()
        prodViewController.product = cartViewModel.carts[indexPath.row].product
        self.navigationController?.pushViewController(prodViewController, animated: true)
    }
    
    @objc func refreshTable() {
        print("refresh started")
        cartViewModel.fetch()
        tableView.reloadData()
        refresher.endRefreshing()
    }

    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
