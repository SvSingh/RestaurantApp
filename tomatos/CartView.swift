//
//  CartView.swift
//  tomatos
//
//  Created by SV Singh on 2022-01-11.
//

import SwiftUI

struct CartView: View {
    
    
    @ObservedObject var order: Order
    @State private var showingNoItemAlert = false
    @State private var showingAlert = false
    
    func calculateSubtotal(price : Double, Quanity : Int) -> Double{
        
        return price * Double(Quanity)
    }
    
   
    
    
    
    
    var body: some View {
        
        VStack{
            
            
           
            HStack(spacing : 20) {
                Text("Items")
                    .fontWeight(.bold)
                    .foregroundColor(Color.primary)
                    .frame(width : 108,alignment : .trailing)
                
                Divider()
                
                
                Text("Quantity")
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
           
            ScrollView {
                VStack {
                    ForEach(self.order.cart)
                    {item in
                        
                        HStack(spacing : 20) {
                            Text(item.menuItem.Item)
                            
                                .fontWeight(.bold)
                                .foregroundColor(Color.primary)
                                .multilineTextAlignment(.trailing)
                                .frame(width : 108,alignment : .trailing)
                            Divider()
                            Text(String(item.Quantity))
                            
                                .fontWeight(.bold)
                                .foregroundColor(Color.primary)
                                .frame(width : 70,alignment : .center)
                            
                            
                            Divider()
                            HStack {
                                Text("$\(String(format: "%.2f",calculateSubtotal(price: Double(item.menuItem.price) ?? 0.00, Quanity: item.Quantity)))") .fontWeight(.bold)
                                    .foregroundColor(Color.primary)
                                    .minimumScaleFactor(0.8)
                                Image(systemName: "trash.circle.fill")
                                    .foregroundColor(Color.red)
                                    .font(.system(size: 30))
                                    .onTapGesture {
                                        withAnimation {
                                            removeCartItem(id: Int(item.menuItem.id))
                                        }
                                    }
                                
                            }
                            .multilineTextAlignment(.trailing)
                            .frame(width : 120,alignment : .trailing)
                            
                            
                        }
                        
                        Divider()
                        
                    }
                }
            }
            .frame(height: 350)
            
            HStack{
                
                Text("")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.primary)
                    .frame(width: 108,alignment: .trailing)
                Text("Subtotal : " )
                    .fontWeight(.semibold)
                    .foregroundColor(Color.primary)
                    .frame(width: 70,alignment: .trailing)
                Text(String(format: "$%.02f",self.order.subtotal))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.primary)
                    .frame(width: 120,alignment: .trailing)
                
            }.frame(alignment: .trailing)
            
            HStack{
                
                Text("")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.primary)
                    .frame(width: 108,alignment: .trailing)
                Text("Tax : " )
                    .fontWeight(.semibold)
                    .foregroundColor(Color.primary)
                    .frame(width: 70,alignment: .trailing)
                Text(String(format: "$%.02f",self.order.GST + self.order.PST + self.order.PLT))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.primary)
                    .frame(width: 120,alignment: .trailing)
                
            }.frame(alignment: .trailing)
            
            Divider()
            
            HStack{
                
                Text("")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.primary)
                    .frame(width: 108,alignment: .trailing)
                Text("Total : " )
                    .fontWeight(.semibold)
                    .foregroundColor(Color.primary)
                    .frame(width: 70,alignment: .trailing)
                Text(String(format: "$%.02f",self.order.subtotal + self.order.GST + self.order.PST + self.order.PLT))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.primary)
                    .frame(width: 120,alignment: .trailing)
                
            }.frame(alignment: .trailing)
            
            
            Button{
                
                if(!self.order.cart.isEmpty){
                    
                    
                    let post = PostOrder(orderDetail: self.order)
                    post.post()
                    
                    self.showingAlert = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        
                        
                        self.order.cart.removeAll()
                        
                        
                        AppState.shared.gameID = UUID()
                    })
                    
                    
                    
                }
                else{
                    self.showingNoItemAlert = true
                    
                }
                
               
                
                
                
            }label: {
                HStack
                    {
                        Text("CheckOut")
                        Image(systemName: "cart.fill")
                    }
                    .padding()
                    .frame(width: 350)
                    .padding(.horizontal,10)
                    .background(Color.red)
                    .cornerRadius(10)
                    .font(.system(size: 20,weight : .bold))
                    .foregroundColor(Color.white)
                    .shadow(color:Color.red.opacity(0.5),radius : 5,x : 0, y : 10)
                    
                   
            }
            
            
        }.font(.system(size: 15))
            .alert("Please add Items to your Cart", isPresented: $showingNoItemAlert) {
                       Button("OK", role: .cancel) { }
                 }
            
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Thank You For Placing order to the restaurant"), message: Text("Your order should be ready within 15 - 30 minutes. Please call the restaurant for exact Confirmation of the time."), dismissButton: .default(Text("Got it!")))
            }
            
        
        
        
    }
    
    func removeCartItem(id : Int){
        
       
        for index in 0..<order.cart.count {
        
            if(order.cart[index].menuItem.id == id){
                self.order.removeItem(id: index)
                break
            }
        }
        
        
    
}
    
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(order: Order())
    }
}





