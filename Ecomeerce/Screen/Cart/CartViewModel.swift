//
//  CartViewModel.swift
//  Ecomeerce
//
//  Created by Riyan Khan on 30/04/23.
//

import Foundation
import CoreData
import UIKit
class CartViewModel {
    typealias fetchHandler  = ()->Void
    
    var carts:[Cart] = []
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var fetchHandle :fetchHandler?
    
    func addCount(cart:Cart){
        do{
            cart.count = cart.count + 1
            try context.save()
         
        }catch{
            print(error)
            print(error.localizedDescription)
        }
      
    }
    
    func makeOrder()->OrderStatus{
        let username = UserDefaults.standard.object(forKey: "username") as! String
        print(username)
        let userRequest = User.fetchRequest()
        let userpred = NSPredicate(format: "userName == %@", username)
        userRequest.predicate = userpred
        do {
            let users = try context.fetch(userRequest)
            if !users.isEmpty{
                let user = users[0]
                print(user)
                
                let cartRequest = Cart.fetchRequest()
                let cartPred = NSPredicate(format: "user == %@", user)
                cartRequest.predicate = cartPred
                let carts = try context.fetch(cartRequest)
                for cart in carts{
                    if cart.count > cart.product!.count {
                        print("insufficient quantity")
                        return .insufficient
                    }
                    
                    let order = Order(context: context)
                    print("added to orders")
                    order.product = cart.product
                    order.count = cart.count
                    order.product!.count = order.product!.count - Int16(cart.count)
                    order.user = user
                    
                    try context.delete(cart)
                    try context.save()
                }
                self.carts = []
                return .sucess
            }
        }catch{
            print(error)
            print(error.localizedDescription)
            return .fail
        }
        return .fail
    }
    
    func minusCount(cart:Cart){
        do{
            cart.count = cart.count - 1
            if (cart.count == 0 || cart.count < 0){
                context.delete(cart)
                print("object delete")
                self.carts = []
            }
            try context.save()
        }catch{
            print(error)
            print(error.localizedDescription)
        }
    }
    
    func fetch(){
        do {
            let request = Cart.fetchRequest()
            let username = UserDefaults.standard.object(forKey: "username") as! String
            let pred = NSPredicate(format: "user.userName == %@",username )
            request.predicate = pred
            let carts = try context.fetch(request)
            if !carts.isEmpty {
                self.carts = carts
                fetchHandle?()
            }
            
        }catch{
            print(error)
            print(error.localizedDescription)
        }
    }

}
