//
//  Order.swift
//  tomatos
//
//  Created by SV Singh on 2022-01-25.
//

import SwiftUI

class Order : ObservableObject {
    
    
    @Published var cart: [cartItem] = []
     
     var subtotal : Double{
        
        if(cart.count != 0){
            var result = 0.0
            for item in cart {
                result = result + ((Double(item.menuItem.price) ?? 0.0) * (Double(item.Quantity)))
                result = Double(round(100 * result) / 100)
            }
            return result
        }
        else{
            return 0.0
        }
        
        
        
    }
    var GST : Double{
        if(cart.count != 0){
            
            var result =   (subtotal*5)/100
            
            result = Double(round(100 * result) / 100)
            
            return result
        }
        else{
            return 0.0
        }
        
    }
    var PLT : Double{
        if(cart.count != 0){
            var result = 0.0
            for item in cart {
                if(item.menuItem.PLT){
                    result = result + ((Double(item.menuItem.price) ?? 0.0) * (Double(item.Quantity))*0.10 )
                    
                    result = Double(round(100 * result) / 100)
                }
                
            }
            return result
        }
        else{
            return 0.0
        }
        
    }
    var PST : Double{
        if(cart.count != 0){
            var result = 0.0
            for item in cart {
                if(item.menuItem.PST){
                    result = result + ((Double(item.menuItem.price) ?? 0.0) * (Double(item.Quantity))*0.10 )
                    result = Double(round(100 * result) / 100)
                }
                
            }
            return result
        }
        else{
            return 0.0
        }
        
        
    }
    
    
    func AddItem(item : cartItem){
        
        self.cart.append(item)
        
    }
    
    func removeItem(id : Int){
        
        self.cart.remove(at: id)
    }
}


struct cartItem : Identifiable {
    
    let id = UUID()
    var  menuItem : Menu
    var Quantity : Int
    
}
