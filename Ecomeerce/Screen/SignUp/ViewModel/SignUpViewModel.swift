//
//  SignUpViewModel.swift
//  Ecomeerce
//
//  Created by Riyan Khan on 01/05/23.
//

import Foundation
import CoreData

class SignUpViewModel {
    var context:NSManagedObjectContext?
    func signUp(username:String,password:String)->SignUpStatus{
        if(username == "" || password == ""){
            return .empty
        }
        
        let request = User.fetchRequest()
        let pred = NSPredicate(format: "userName == %@", username)
        request.predicate = pred
        do {
            let users = try context!.fetch(request)
            print(users)
            if !users.isEmpty {
                return .exist
            }else{
                let user = User(context: context!)
                user.userName = username
                user.password = password
                try context!.save()
                return .sucess
            }
        }catch{
            print(error)
            print(error.localizedDescription)
            return .failed
        }
        return .failed
    }
}
