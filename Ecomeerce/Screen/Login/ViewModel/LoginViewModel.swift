//
//  LoginViewModel.swift
//  Ecomeerce
//
//  Created by Riyan Khan on 30/04/23.
//

import Foundation
import CoreData

class LoginViewModel {
    var context:NSManagedObjectContext? = nil
    
    func loadDataIfDoesNotExist(){
        let refreshData = false
        
        if refreshData{
            
            let userFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            let productFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
            let orderFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Order")
            let cartFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
            let userDelete = NSBatchDeleteRequest(fetchRequest: userFetchRequest)
            let prodDelete = NSBatchDeleteRequest(fetchRequest: productFetchRequest)
            let orderDelete = NSBatchDeleteRequest(fetchRequest: orderFetchRequest)
            let cartDelete = NSBatchDeleteRequest(fetchRequest: cartFetchRequest)
            do {
                try context!.execute(userDelete)
                try context!.execute(prodDelete)
                try context!.execute(orderDelete)
                try context!.execute(cartDelete)
                try context!.save()
                print("done deleteting")

            } catch {
                print (error)
                print(error.localizedDescription)
            }
        }
  
        DispatchQueue.main.async {
            do {
                let prdts = try self.context!.fetch(Product.fetchRequest())
                if (prdts.isEmpty) {
                        let productNames = ["Shirt", "Jeans", "Sweater", "Jacket", "Dress", "Skirt", "Blouse", "Pants", "Shorts", "T-Shirt"]
                        let productDescriptions = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus.", "Pellentesque in ipsum id orci porta dapibus.", "Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui.", "Nulla quis lorem ut libero malesuada feugiat. Nulla porttitor accumsan tincidunt.", "Vivamus suscipit tortor eget felis porttitor volutpat.", "Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a.", "Sed porttitor lectus nibh.", "Donec sollicitudin molestie malesuada.", "Quisque velit nisi, pretium ut lacinia in, elementum id enim.", "Nulla porttitor accumsan tincidunt. Nulla quis lorem ut libero malesuada feugiat."]
                        let categories = ["Men", "Women", "Kids", "Accessories"]
                        let productImages = [["shirt1.jpg", "shirt2.jpg", "shirt3.jpg"], ["jeans1.jpg", "jeans2.jpg", "jeans3.jpg"], ["sweater1.jpg", "sweater2.jpg", "sweater3.jpg"], ["jacket1.jpg", "jacket2.jpg", "jacket3.jpg"], ["dress1.jpg", "dress2.jpg", "dress3.jpg"], ["skirt1.jpg", "skirt2.jpg", "skirt3.jpg"], ["blouse1.jpg", "blouse2.jpg", "blouse3.jpg"], ["pants1.jpg", "pants2.jpg", "pants3.jpg"], ["shorts1.jpg", "shorts2.jpg", "shorts3.jpg"], ["tshirt1.jpg", "tshirt2.jpg", "tshirt3.jpg"]]
                        
                        for i in 0..<productNames.count {
                            let product = Product(context: self.context!)
                            product.name = productNames[i]
                            product.des = productDescriptions[i]
                            product.categorie = categories[i % categories.count]
                            product.price = Int16((i + 1) * 10)
                            product.count = Int16((i + 1) * 10)
                            product.image = productImages[i % productImages.count]
                            try self.context!.save()
                            print("products added")
                        }
                 
                }
            }
            catch{
                print(error)
                print(error.localizedDescription)
            }
        }
    }
    
    func checkLoginUser(username:String,password:String)->LoginStatus{
        print("cheking")
        
        try? context?.save()
        
        if(username == "" || password == ""){
            return .empty
        }

        let request = User.fetchRequest() as NSFetchRequest<User>
        
        let pred = NSPredicate(format: "userName == %@", username )
        
        request.predicate = pred
        
        do {
            let users = try context!.fetch(request)
            if (users.count > 0 && users.count < 2){
                let user = users[0]
                if (user.password == password){
                    print("user found")
                    return .sucess
                }
                print("wrong password")
            }
            print("wrong userName")
            return .wrong
        }catch{
            
            print(error)
            print(error.localizedDescription)
            return .failed
        }
        return .failed
    }
}
