//
//  HomeControllerTableViewController.swift
//  Ecomeerce
//
//  Created by Riyan Khan on 30/04/23.
//

import UIKit

class HomeControllerTableViewController: UITableViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let homeViewModel = HomeViewModel()
    var refresher = UIRefreshControl()
    var categories:[String] = []
    
    override func viewDidLoad() {

        super.viewDidLoad()
        self.view.backgroundColor = .white
        tableView.addSubview(refresher)
        configureViewModel()
        configureTable()
        configurePicker()
    }
    
    func configurePicker(){
        let filterPickerView = UIPickerView()
        filterPickerView.dataSource = self
        filterPickerView.delegate = self
        let filterButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButtonTapped))
        navigationItem.rightBarButtonItem = filterButton
   
    }
    
    func configureViewModel(){
        homeViewModel.context = self.context
        
        homeViewModel.fetchDatahandle = {
            print("data handler called")
            self.tableView.reloadData()
        }
        
        homeViewModel.fetchProducts()
        self.categories = homeViewModel.getListOfCategories()
        categories.append("None")
    }
    
    func configureTable(){
        tableView.register(UINib(nibName: "HomeViewCell", bundle: nil), forCellReuseIdentifier: "HomeViewCellId")
        tableView.rowHeight = CGFloat(133)
        refresher.addTarget(self, action: #selector(refreshTable), for: .valueChanged )
        }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1   }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  homeViewModel.products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeViewCellId", for: indexPath) as! HomeViewCell
        let prod =  homeViewModel.products[indexPath.row]
        var card = HomeCard()
        card.name = prod.name!
        card.price = "\(prod.price)"
        cell.setData(data:card)
        cell.productImageView.image = Common.image(from: prod.image![0])
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let prodViewController = ProductViewController()
        prodViewController.product = homeViewModel.products[indexPath.row]
        self.navigationController?.pushViewController(prodViewController, animated: true)
    }
    
    @objc func refreshTable() {
        print("refresh started")
        homeViewModel.fetchProducts()
        tableView.reloadData()
        refresher.endRefreshing()
    }
    
    @objc func filterButtonTapped() {
        
        print("function begin")
        let alertController = UIAlertController(title: "Filter by Category", message: nil, preferredStyle: .actionSheet)
             
             for category in categories {
                 let action = UIAlertAction(title: category, style: .default, handler: { [weak self] _ in
                     // Filter the products array by the selected category and reload the table view
                     self!.homeViewModel.filterProducts(by: category)
                     self!.tableView.reloadData()
                 })
                 alertController.addAction(action)
             }
             
             let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
             alertController.addAction(cancelAction)
             
             present(alertController, animated: true, completion: nil)
    }
}


extension HomeControllerTableViewController :  UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
          return 1
      }

      func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
          return categories.count
      }

      // MARK: - UIPickerViewDelegate

      func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
          return categories[row]
      }

      func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
          print( categories[row])
          navigationItem.titleView?.becomeFirstResponder()
      }
}
