//
//  MenuDetailView.swift
//  tomatos
//A
//  Created by SV Singh on 2021-12-13.
//

import SwiftUI

struct MenuDetailView: View {
    
    
    let menuItem : Menu
    var menuinitialize = MenuInitialize()
    
    
    @State var num = 1
    
    /*
     init(menuItem: Menu) {
     
     self.menuItem = menuItem
     
     numberFormatter = NumberFormatter()
     numberFormatter.numberStyle = .currency
     numberFormatter.maximumFractionDigits = 2
     
     
     UITableView.appearance().backgroundColor = .clear
     UITableViewCell.appearance().backgroundColor = .clear
     }*/
    var body: some View {
        
        backView().overlay(
            
            VStack( alignment:.center) {
                
                Image("Masala")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(30)
                    .ignoresSafeArea(.container, edges: .top)
                    
                
                VStack(alignment : .center){
                    Text(menuItem.Item)
                        .font(.system(size: 50))
                        .bold()
                        .underline()
                        .frame(height: 150, alignment: .leading)
                        .multilineTextAlignment(.center)
                    Text(menuItem.Discription)
                        .frame(height: 50, alignment: .leading)
                        .multilineTextAlignment(.center)
                    Text("$ \(menuItem.price).00")
                        .font(.system(size: 30))
                        .bold()
                    
                    HStack(spacing : 20){
                        Button{
                            if(num != 1){
                                num = num - 1
                            }
                        }label: {
                            Image(systemName: "minus.circle.fill")
                                .foregroundColor(Color.red)
                        }
                        Text("\(num)")
                        Button{
                            num = num + 1
                        }label: {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(Color.red)
                        }
                    }
                    .font(.system(size: 30))
                    .offset(x:10)
                    
                    
                    
                    
                }
                
                
                
                
                Button{}label: {
                    HStack {
                        Text("Total : $ \(num * Int(menuItem.price)!).00")
                        
                        Spacer()
                        
                        HStack
                        {
                            Text("Add to Cart")
                            Image(systemName: "cart.fill")
                        }
                        
                    }
                    .padding()
                    .padding(.horizontal,10)
                    .background(Color.red)
                    .cornerRadius(10)
                    .font(.system(size: 20,weight : .bold))
                    .foregroundColor(Color.white)
                }
                .frame(width : 360)
                
                
                Spacer()
                
                HStack{
                    
                    ForEach(1..<6) { i in
                        Image(systemName: "trash.circle")
                    }
                }
                
                
                
                
            }
            
            
            
        )
        
         
    }
    
}

struct MenuDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MenuDetailView(menuItem: Menu(id: 11, Item: "Paneer Pakora", price: "11", sold: Optional(0), left: Optional(0), GST: true, PLT: false, PST: false, category_id: 4, Discription: "Cheese battered with chick pea flour and deep and deep fried"))
        
    }
}
