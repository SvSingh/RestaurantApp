//
//  OrderFetch.swift
//  tomatos
//
//  Created by SV Singh on 2022-02-22.
//

import Foundation

import SwiftUI

struct OrderPars : Codable, Identifiable {
    
    
    
    public var id : Int {
        if let id = order_ID {
            return id
        }
        else {
            return 0
        }
    }
    
    var order_ID: Int?
    var Date: String
    var Time: String
    var Active: Bool
    var paymentType: String?
    var Tip: Double?
    var GST: Double?
    var PLT: Double?
    var SubTotal: Double
    var Table: String?
    var TakeOutNumber: Int?
    var Guest: Int
    var Cutomer_name_id: Int?
    var DiscountPrice: Double
    var Discount: String?
    var PST: Double?
    
    
}

struct OrderItem : Codable,Identifiable {
    
    
    var id : Int?
    var Active : Bool
    var Qty : Int
    var GuestId : Int
    var Item_id : Int
    var order_ID_id : Int
    var Comment: String?
    
    
    
}

class FetchOrder {
    
    var orders = [OrderPars]()
    var orderItem = [OrderItem]()
    
    func fetchOrderItems(orderId : Int){
        
        let url = URL(string: "https://tomatos.ca/Laravel/api/OrderItem/\(orderId)")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            if let data = data {
                
                do {
                    let decoder = JSONDecoder()
                    
                    
                    let Results = try decoder.decode([OrderItem].self, from: data)
                    DispatchQueue.main.async {
                        self.orderItem = Results
                       
                    }
                }
                
                catch {
                    print (error)
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        
        task.resume()
        
    }
    
    func fetchCustomerID (CustomerId : Int){
        
        let url = URL(string: "https://tomatos.ca/Laravel/api/OrderCustomId/\(CustomerId)")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        
        
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            if let data = data {
                
                do {
                    let decoder = JSONDecoder()
                    
                    
                    let Results = try decoder.decode([OrderPars].self, from: data)
                    DispatchQueue.main.async {
                        self.orders = Results
                    }
                }
                
                catch {
                    print (error)
                }
                
                
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        
        task.resume()
        
        
    }
    
    
    
}


class PostOrder {
    
    
    var order : OrderPars?
    
    var orderDetail : Order
    
    var customerId = UserDefaults.standard.object(forKey: "id") as? Int ?? 0
    
    init(orderDetail : Order){
        
        self.orderDetail = orderDetail
        
    }
    
     func post (){
         
         
         let myGroup = DispatchGroup()
         myGroup.enter()
         
             self.postOrderdetail()
         
         myGroup.leave()
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
             self.postOrderItems()
         })
         
     }
      
    func postOrderdetail(){
        
        let url = URL(string: "https://tomatos.ca/Laravel/api/Order")
        
        
       guard let requestUrl = url else { fatalError() }
       var request = URLRequest(url: requestUrl)
       request.httpMethod = "POST"
       
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "yyyy-MM-dd"
       
       let TimeFormat = DateFormatter()
      
       
       TimeFormat.dateFormat = "HH:mm:ss.SSS"
       
       
        let body = OrderPars( Date: dateFormatter.string(from: Date()), Time: TimeFormat.string(from : Date()), Active: true, paymentType: "Online", Tip: 0.0, GST: orderDetail.GST, PLT: orderDetail.PLT, SubTotal: orderDetail.subtotal, Table: "Online", Guest: 1, Cutomer_name_id : customerId, DiscountPrice: 0, PST: orderDetail.PST)
       
       
       request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
       
       request.httpBody = try? JSONEncoder().encode(body)
       
       let task =  URLSession.shared.dataTask(with: request){ (data, response, error) in
               
           
               if let error = error {
                   print("Error took place \(error)")
                   return
               }
        
               
           if let data = data {
               do{
              
                   let result = try JSONDecoder().decode(OrderPars.self, from: data)
                   
                   self.order = result
                  
               }
                catch {
                   print(error)
              }
           }
              
       }
        
       task.resume()
       
   }
    
    
    
    func postOrderItems(){
        
        
        func ss(){
            
            if((self.order) == nil){
                ss()
            }else{
                if let order  = order{
                    
                     let url = URL(string: "https://tomatos.ca/Laravel/api/OrderItem")
                     guard let requestUrl = url else { fatalError() }
                     var request = URLRequest(url: requestUrl)
                     request.httpMethod = "POST"
                     for item in orderDetail.cart {
                         let body = OrderItem(Active: true, Qty:item.Quantity, GuestId: 1, Item_id: item.menuItem.id, order_ID_id: order.order_ID!, Comment:"")
                         request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                         do { request.httpBody = try JSONEncoder().encode(body)
                         }catch {
                             print(error)
                         }
                           let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
                                 
                                 // Check for Error
                                 if let error = error {
                                     print("Error took place \(error)")
                                     return
                                 }
                          
                                
                         }
                          
                         task.resume()
                         
                         
                         
                         
                    }
                     
                     
                 }
                
            }
            
            
        }
        
      ss()
        
    }
    
    
}

