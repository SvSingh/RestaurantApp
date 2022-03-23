//
//  AcoountOrders.swift
//  tomatos
//
//  Created by SV Singh on 2022-02-22.
//

import SwiftUI

struct AcoountOrders: View {
    
   
    @State var id : Int =  0
    
    @State  var userDefault = UserDefaults.standard
    
    @State var activeOrder = false
    @State  var orders = [OrderPars]()
    
    var body: some View {
        VStack{
            
            HStack(spacing : 20) {
                Text("Date")
                    .fontWeight(.bold)
                    .foregroundColor(Color.primary)
                    .frame(width : 108,alignment : .trailing)
                
                Divider()
                
                
                Text("Order ID")
                    .fontWeight(.bold)
                    .foregroundColor(Color.primary)
                    .frame(width : 70,alignment : .center)
                
                Divider()
                
                Text("Subtotal")
                    .fontWeight(.bold)
                    .foregroundColor(Color.primary)
                    .frame(width : 120,alignment : .leading)
                
                
            }
            .frame(height : 50)
            .background(Color.red)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.horizontal,20)
            .shadow(color:Color.red.opacity(0.5),radius : 5,x : 0, y : 10)
            
            Divider()
            VStack(alignment : .leading) {
                
                Text("Active Orders")
                ScrollView{
                    
                    VStack{
                        ForEach(orders){order in
                            if(order.Active){
                                
                                
                                NavigationLink(destination: OrderDetailView(order: order).navigationBarBackButtonHidden(false)){
                                    HStack {
                                        Text("\(order.Date)")
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.primary)
                                            .frame(width : 108,alignment : .leading)
                                        
                                        Divider()
                                        Text(String(order.order_ID!))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.primary)
                                            .frame(width : 70,alignment : .center)
                                        Divider()
                                        Text("$\(String(format: "%.2f",order.SubTotal))")
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.primary)
                                            .frame(width : 120,alignment : .trailing)
                                    }.frame(width: 380, height: 70)
                                    
                                        .background( Color.primary.opacity(0.1)
                                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                                        .frame(maxWidth : .infinity))
                                    
                                }.onAppear(){
                                    for order in orders {
                                        if(order.Active){
                                            activeOrder = true
                                        }
                                    }
                                }
                                
                            }
                            
                            
                            
                            
                        }
                        if(!activeOrder){
                            Text("You dont have any Active Orders For Now!")
                        }
                        
                    }
                    
                }.frame(height : 150)
            }
            
            VStack(alignment : .leading) {
                
                Text("Compeleted Orders")
                ScrollView{
                    
                    VStack{
                        ForEach(orders){order in
                            if(!order.Active){
                                NavigationLink(destination: OrderDetailView(order: order).navigationBarBackButtonHidden(false)){
                                    HStack {
                                        Text("\(order.Date)")
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.primary)
                                            .frame(width : 108,alignment : .leading)
                                        
                                        Divider()
                                        Text(String(order.order_ID!))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.primary)
                                            .frame(width : 70,alignment : .center)
                                        Divider()
                                        Text("$\(String(format: "%.2f",order.SubTotal))")
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.primary)
                                            .frame(width : 120,alignment : .trailing)
                                    }.frame(width: 380, height: 70)
                                    
                                        .background( Color.primary.opacity(0.1)
                                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                                        .frame(maxWidth : .infinity))
                                    
                                }
                            }
                        }
                        
                    }
                    
                    
                }
                
            }
            
        }
        
        
        
        .onAppear {
            
            self.id = userDefault.object(forKey: "id") as? Int ?? 0
            
            
            let fetchorder = FetchOrder()
            if(self.id != 0){
               
                fetchorder.fetchCustomerID(CustomerId: self.id)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    orders = fetchorder.orders
                    orders.reverse()
                })
                
                
            }
            
        }
    }
}

struct AcoountOrders_Previews: PreviewProvider {
    static var previews: some View {
        AcoountOrders()
    }
}
