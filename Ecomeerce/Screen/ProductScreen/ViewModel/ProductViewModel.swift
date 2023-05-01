//
//  ProductViewModel.swift
//  Ecomeerce
//
//  Created by Riyan Khan on 30/04/23.
//

import Foundation
import CoreData


class ProductViewModel {
    var context:NSManagedObjectContext?
    func addToCart(product:Product)->CartAddStatus{
        do {
            let usernameRaw = UserDefaults.standard.object(forKey: "username")
            
            if usernameRaw != nil {
                let username = usernameRaw as! String
                let request = User.fetchRequest()
                let pred = NSPredicate(format: "userName == %@", username)
                
                request.predicate = pred
                
                let users = try context?.fetch(request)
                if users != nil{
                    let user:User = users![0]
                    print("got user")
                    let fetchRequest: NSFetchRequest<Cart> = Cart.fetchRequest()
                    fetchRequest.predicate = NSPredicate(format: "product == %@ AND user == %@", product, user)
                    let carts:[Cart] = try context!.fetch(fetchRequest)
                    print("got carts")
                    if !carts.isEmpty {
                        print("already added in cart")
                        let cart = carts[0]
                        cart.count = cart.count + 1
                        try context!.save()
                        print("done")
                        return .success
            
                    }else{
                        print("new cart created")
                        let cart = Cart(context: context!)
                        cart.product = product
                        cart.user = user
                        cart.count = 1
                        try context!.save()
                    }
      
                    print("done")
                    return .success
                }
                return .failed
                
            }
 
        }catch{
            print(error)
            print(error.localizedDescription)
            return .failed
        }
        return .failed
    }
}
