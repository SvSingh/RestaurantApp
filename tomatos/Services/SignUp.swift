//
//  SignUp.swift
//  tomatos
//
//  Created by SV Singh on 2022-04-08.
//

import Foundation
struct signupPerson : Codable {
    
    
    var Customer_name : String
    var phone_number : String
    var email : String
    var password : String
    var password_confirmation : String
}


class signup : ObservableObject {
    
    
    @Published var Success : Bool = false
    @Published var error : Bool = false
    
    
    var signupDetail : signupPerson = signupPerson(Customer_name: "", phone_number: "", email: "", password: "", password_confirmation : "")
    var signedInDetail : Person!
    
    func signup() {
        let url = URL(string: "https://tomatos.ca/Laravel/api/create-account")
        
        
       guard let requestUrl = url else { fatalError() }
       var request = URLRequest(url: requestUrl)
       request.httpMethod = "POST"
       
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let jsonData = try? JSONEncoder().encode(signupDetail)
        
        //print(try? JSONSerialization.jsonObject(with: jsonData, options: []))
        
       
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
                
                // Check for Error
                if let error = error {
                    print("Error took place \(error)")
                    return
                }
         
                
            if let data = data {
                do{
                    print(try? JSONSerialization.jsonObject(with: data, options: []))
                    let result = try JSONDecoder().decode(Person.self, from: data)
                   self.signedInDetail = result
                    
                    UserDefaults.standard.set(self.signedInDetail?.token, forKey: "APIKEY")
                    UserDefaults.standard.set(self.signedInDetail?.Customer.password, forKey: "Password")
                    UserDefaults.standard.set(self.signedInDetail?.Customer.Customer_name, forKey: "name")
                    UserDefaults.standard.set(self.signedInDetail?.Customer.email, forKey: "email")
                    UserDefaults.standard.set(self.signedInDetail?.Customer.phone_number, forKey: "phone")
                    UserDefaults.standard.set(self.signedInDetail?.Customer.id, forKey: "id")
                    
                    self.Success = true
                    
                 }
                 catch {
                     self.error = true
                    print(error)
               }
            
            
            }
               
        
        }
        task.resume()
        
        
        
        
    }
    
    
    
}
