//
//  LoginModel.swift
//  tomatos
//
//  Created by SV Singh on 2022-02-15.
//

import Foundation

import SwiftUI

struct loginCredentials : Codable {
    
   var email : String
    var password : String
}

struct Person : Codable {
    
    
    var Customer : Customer
    var token : String
    
}


struct Customer : Codable {
    var id: Int!
    var Customer_name: String
    var phone_number: String
    var email: String
    var password: String
    var password_confirmation : String!
       
}

class LoginModel : ObservableObject {
    @Published var Success = false
    var person : Person?
    
    func  SignIn(credentials : loginCredentials){
        
        
        let url = URL(string: "https://tomatos.ca/Laravel/api/signin")
        
        
       guard let requestUrl = url else { fatalError() }
       var request = URLRequest(url: requestUrl)
       request.httpMethod = "POST"
       
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let jsonData = try? JSONEncoder().encode(credentials)
        
        
       
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
                
                // Check for Error
                if let error = error {
                    print("Error took place \(error)")
                    return
                }
         
                
            if let data = data {
                do{
                    
                    let result = try JSONDecoder().decode(Person.self, from: data)
                   self.person = result
                    
                    UserDefaults.standard.set(self.person?.token, forKey: "APIKEY")
                    UserDefaults.standard.set(self.person?.Customer.password, forKey: "Password")
                    UserDefaults.standard.set(self.person?.Customer.Customer_name, forKey: "name")
                    UserDefaults.standard.set(self.person?.Customer.email, forKey: "email")
                    UserDefaults.standard.set(self.person?.Customer.phone_number, forKey: "phone")
                    UserDefaults.standard.set(self.person?.Customer.id, forKey: "id")
                    
                    self.Success = true
                    
                 }
                 catch {
                    print(error)
               }
            }
            
            
               
        }
         
        task.resume()
        
       
        
    }
    
}
