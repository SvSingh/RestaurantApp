//
//  menuView.swift
//  tomatos
//
//  Created by SV Singh on 2022-01-09.
//

import SwiftUI

struct menuView: View {
    
    @ObservedObject var order: Order

    
    
    var menuinitialize = MenuInitialize()
    var categorInitialize = categoryInitialize()
    @State var menuItems = [Menu]()
    @State var categories = [Category]()
    
    var body: some View {
        
        VStack{
            
            ScrollView (.horizontal, showsIndicators: false) {
                HStack (spacing: 10){
                    ForEach(categories){ category in
                        
                        Button{
                            withAnimation(.easeOut) {
                                self.menuItems = self.menuinitialize.fetchMenu(category: category.id)
                            }
                            
                        }label: {
                            
                            VStack{
                                
                                Image(systemName:"fork.knife.circle").resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height:70)
                                    .shadow(radius: 10)
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(Color.red)
                                
                                Text(category.name)
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(.primary)
                            }
                        }.padding()
                        
                    }
                }
            }.frame(height: 100)
            
            Divider()
            ScrollView {
                
                
                VStack(alignment : .leading) {
                    ForEach(menuItems){ menuItem in
                        
                        
                        HStack {
                            Image("TomatoLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(height:70,alignment: .leading)
                                .shadow(radius: 10)
                                .overlay(Circle().stroke(Color.red, lineWidth: 1))
                                .frame(width: 50, height: 50)
                            
                            Divider()
                            VStack(alignment : .leading) {
                                
                                Text(menuItem.Item.trimmingCharacters(in: .whitespacesAndNewlines))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.primary)
                                    
                                
                                
                                
                                Text(menuItem.Discription)
                                    .font(.subheadline)
                                    .foregroundColor(Color.secondary)
                                    .frame(alignment : .leading)
                                    .minimumScaleFactor(0.5)
                                
                            }
                            .frame(width: 150,alignment: .leading)
                            
                            ADDButtonView(order: order, MenuItem: menuItem)
                            
                        }
                        .padding()
                        .background( Color.primary.opacity(0.1)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                     
                                        .frame(maxWidth : .infinity))
                        
                    }
                }.padding()
                
            }.frame(height: 500)
            
            
        }
        
        
        
        
        
        
        .onAppear{
            
            self.categorInitialize.initialize()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.categories = self.categorInitialize.category
                
                self.menuItems = self.menuinitialize.fetchMenu(category: 4)
                
                
            })
            
        }
    }
}

struct menuView_Previews: PreviewProvider {
    static var previews: some View {
        menuView(order: Order())
    }
}


struct ADDButtonView: View {
    
    @ObservedObject var order: Order

    
    let MenuItem : Menu
    
    var price : Double {
        return Double( MenuItem.price) ?? 0.00
    }
    
    @State var num = 1
    
    var Total : String {
        
        return String(format: "%.2f",(price * Double(num)))
        
        
    }
    
    
    var body: some View {
        VStack{
            
            
            HStack{
                
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
            
            Button{
                
                order.cart.append(cartItem(menuItem: MenuItem, Quantity: num))
                
                
            }label:{
                
                Text("Add $\(Total)")
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                    .padding()
                    .frame(width: 100, height: 60)
                    .background(Color.red)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .minimumScaleFactor(0.5)
                }
            
            
            
        }
    }
}



