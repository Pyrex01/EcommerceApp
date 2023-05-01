//
//  HomeViewModel.swift
//  Ecomeerce
//
//  Created by Riyan Khan on 30/04/23.
//

import Foundation
import UIKit
import CoreData

class HomeViewModel {
    
    typealias fetchDataHandler = ()->Void
    
    var fetchDatahandle:fetchDataHandler?
    
    var products:[Product] = []
    var context:NSManagedObjectContext? = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchProducts(){
        do {
            let prodRequest = Product.fetchRequest()
            let prodPred = NSPredicate(format: "count > 0",[])
            prodRequest.predicate = prodPred
            self.products = try  context!.fetch(prodRequest)
            fetchDatahandle?()	
        }
        catch{
            print(error)
            print(error.localizedDescription)
        }
    }
    
    func getListOfCategories()->[String]{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        fetchRequest.resultType = .dictionaryResultType
        fetchRequest.propertiesToFetch = ["categorie"]
        fetchRequest.returnsDistinctResults = true

        do {
            let categories = try context!.fetch(fetchRequest) as! [NSDictionary]
            return categories.compactMap { $0.value(forKey: "categorie") as? String }
            
        } catch {
            print("Error fetching categories: \(error.localizedDescription)")
        }
        return []
    }
    
    func filterProducts(by categorie:String){
        print(categorie)
        if(categorie == "None"){
            do {
                let prodRequest = Product.fetchRequest()
                let prodPred = NSPredicate(format: "count > 0",[])
                prodRequest.predicate = prodPred
                self.products = try  context!.fetch(prodRequest)
                fetchDatahandle?()
            }
            catch{
                print(error)
                print(error.localizedDescription)
            }
            return
        }
        
        do {
            let request = Product.fetchRequest()
            let pred = NSPredicate(format: "categorie == %@ && count > 0", categorie)
            request.predicate = pred
            self.products = try  context?.fetch(request) ?? []
            fetchDatahandle?()
        }catch{
            print(error)
            print(error.localizedDescription)
        }
    }
    
    
}
