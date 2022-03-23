//
//  ContentView.swift
//  tomatos
//
//  Created by SV Singh on 2021-11-30.
//

import SwiftUI

struct ContentView: View {
    
    
    
    @State private var selected  = 0
    
    @ObservedObject var order = Order()
    
    
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        
        
    }
    
    var body: some View {
        
        
        backView()
            .overlay(
                GeometryReader { geometry in
                    VStack {
                        
                        Image("TomatoLogo").resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height:70)
                            .shadow(radius: 10)
                        
                        
                        SwiftUI.TabView(selection: $selected){
                            
                            menuView(order: order)
                                .tag(0)
                                
                            CartView(order: order)
                                .tag(1)
                            
                            AcoountOrders()
                                .tag(2)
                            
                            AccountInfoView()
                                .tag(3)
                               
                                
                        }
                        .ignoresSafeArea()
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        
                   
                        
                        TabView(Selected:$selected,cartItem: 1).frame(width: geometry.size.width - 15, height: geometry.size.height/10)
                            .background(Color.primary.opacity(0.1).ignoresSafeArea())
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            
                        
                        
                    }.ignoresSafeArea(.all, edges: .bottom)
                }
            )
        
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.light)
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}


struct backView: View {
    
    
    var body : some View{
        
        ZStack {
            
            Color("background").ignoresSafeArea()
            
            Circle()
                .fill(Color.red.opacity(0.3))
                .frame(width:200)
                .blur(radius: 10.0)
                .offset(x: -150,y: -300)
            
            Rectangle()
                .fill(Color.green.opacity(0.3))
                .frame(width:300,height: 250)
                .blur(radius: 10.0)
                .offset(x: 350,y: 150)
                .rotationEffect(Angle(degrees: 45))
            
        }
        
    }
}
