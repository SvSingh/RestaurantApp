//
//  OrderDetailView.swift
//  tomatos
//
//  Created by SV Singh on 2022-02-22.
//

import SwiftUI

struct OrderDetailView: View {
    
    
    var order : OrderPars
    
    @State var orderItem = [cartItem]()
    
    
    
    var total : Double{
        
        return order.SubTotal  + (order.GST ?? 0.0) + (order.PST ?? 0.0) + (order.PLT ?? 0.0)
    }
    
    
    func multiply (x : Double, y: Double) -> Double {
        
        
        
        return x * y
    }
    var body: some View {
        
        ZStack {
            backView()
            VStack ( spacing: 10){
                
                
                HStack {
                    Text("Your Order Number is :")
                        .fontWeight(.bold)
                        .foregroundColor(Color.primary)
                    Text(String(order.order_ID!))
                        .fontWeight(.heavy)
                        .underline()
                        .foregroundColor(Color.primary)
                } .padding()
                    .frame(width: 380, height: 70,alignment: .leading)
                
                    .background( Color.primary.opacity(0.1)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .frame(maxWidth : .infinity))
                
                HStack {
                    Text("Order Placed on:")
                        .fontWeight(.bold)
                        .foregroundColor(Color.primary)
                    Text("\(order.Date)")
                        .fontWeight(.bold)
                        .foregroundColor(Color.primary)
                }.padding()
                    .frame(width: 380, height: 70,alignment: .leading)
                
                    .background( Color.primary.opacity(0.1)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .frame(maxWidth : .infinity))
                
                HStack {
                    Text("Order's Total Amount is $")
                        .fontWeight(.bold)
                        .foregroundColor(Color.primary)
                    Text("\(String(format: "%.2f",total))")
                        .underline()
                        .fontWeight(.heavy)
                    
                        .foregroundColor(Color.primary)
                }   .padding()
                    .frame(width: 380, height: 70,alignment: .leading)
                
                    .background( Color.primary.opacity(0.1)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .frame(maxWidth : .infinity))
                
                VStack (alignment : .center){
                    Text("Order Items:")
                        .fontWeight(.bold)
                        .foregroundColor(Color.primary)
                        .padding()
                    
                    HStack() {
                        Text("Items")
                            .fontWeight(.bold)
                            .foregroundColor(Color.primary)
                            .frame(width : 108,alignment : .trailing)
                        
                        Divider()
                        
                        
                        Text("Quantity")
                            .fontWeight(.bold)
                            .foregroundColor(Color.primary)
                            .frame(width : 80,alignment : .center)
                        
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
                    
                    ScrollView{
                        ForEach(orderItem){item in
                            HStack {
                                Text("\(item.menuItem.Item)")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.primary)
                                    .frame(width : 108,alignment : .trailing)
                                
                                Divider()
                                
                                
                                Text("\(item.Quantity)")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.primary)
                                    .frame(width : 70,alignment : .center)
                                
                                Divider()
                                
                                Text("$\(String(format: "%.2f",multiply(x:Double(item.menuItem.price) ?? 0,y: Double(item.Quantity))))")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.primary)
                                    .frame(width : 120,alignment : .trailing)
                                
                            }
                            
                            Divider()
                        }
                        
                        
                        
                    }
                    
                    
                    Spacer()
                }.frame(width: 380, height: 500,alignment: .leading)
                    .background( Color.primary.opacity(0.1)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .frame(maxWidth : .infinity))
                
                
                
            }
            
            .frame(alignment : .leading)
        }
        
        .onAppear {
            
            let fetchorder = FetchOrder()
            
            fetchorder.fetchOrderItems(orderId: self.order.order_ID!)
            
            let menu = MenuInitialize()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                print(menu.menuItems)
                print(fetchorder.orderItem)
                for item in fetchorder.orderItem {
                    for menuItem in menu.menuItems{
                        
                        if(item.Item_id == menuItem.id){
                            orderItem.append(cartItem(menuItem: menuItem, Quantity: item.Qty))
                        }
                        
                    }
                }
                
                print(orderItem)
            })
        }
    }
}

struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailView(order: OrderPars(order_ID : 37,
                                         Date : "2020-04-22",
                                         Time : "20:06:09.000000",
                                         Active : false,
                                         paymentType : "Visa",
                                         Tip : 0,
                                         GST : 0.82,
                                         PLT : 0,
                                         SubTotal : 16.46,
                                         Table : "null",
                                         TakeOutNumber : 1,
                                         Guest : 1,
                                         Cutomer_name_id : 34,
                                         DiscountPrice : 0,
                                         Discount : "",
                                         PST : 0))
    }
}
