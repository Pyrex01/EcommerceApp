//
//  MainTabBarController.swift
//  Ecomeerce
//
//  Created by Riyan Khan on 30/04/23.
//

import UIKit

class MainTabBarController: UITabBarController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let homeControllerTableViewController = HomeControllerTableViewController()
    let cartTableViewController = CartTableViewController()
    let profileViewController = ProfileController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
        print("view loaded")
        self.view.backgroundColor = .white
      
        let vc1 = UINavigationController(rootViewController: homeControllerTableViewController)
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc1.title = "Home"
        
     
        let vc2 = UINavigationController(rootViewController: cartTableViewController)
        vc2.tabBarItem.image = UIImage(systemName: "cart")
        vc2.title = "Cart"

      
        let vc3 = UINavigationController(rootViewController: profileViewController)
        vc3.tabBarItem.image = UIImage(systemName: "person")
        vc3.title = "Profile"

        tabBar.tintColor = .systemBlue
        tabBar.backgroundColor = .white
        
        setViewControllers([vc1,vc2,vc3], animated: true)
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch(item.title){
        case "Cart":
            cartTableViewController.cartViewModel.fetch()
            break
        case "Home":
            homeControllerTableViewController.homeViewModel.fetchProducts()
            break
        case .none:
            break
        case .some(_):
            break
        }
    }
    

}
