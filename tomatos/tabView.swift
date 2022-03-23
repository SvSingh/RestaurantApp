//
//  tabView.swift
//  tomatos
//
//  Created by SV Singh on 2022-01-09.
//

import SwiftUI

struct TabView: View {
    
    @Binding var Selected: Int
    
    
    var cartItem : Int
    
    var body: some View {
        GeometryReader { geometry in
        HStack {
            
            TabBarIcon(width: geometry.size.width/4, height: 25, systemIconName: "list.bullet", iconLabel: "Menu",foreground: (self.Selected == 0 ? Color.red: Color.primary))
                
                .onTapGesture {
                    
                    withAnimation {
                        self.Selected = 0
                    }
                   
                }
            TabBarIcon(width: geometry.size.width/4, height: 25, systemIconName: "cart.fill", iconLabel: "Cart",foreground: (self.Selected == 1 ? Color.red: Color.primary))
                .onTapGesture {
                    withAnimation {
                        self.Selected = 1
                    }
                }
            TabBarIcon(width: geometry.size.width/4, height: 25, systemIconName: "bag.fill", iconLabel: "My Order",foreground: (self.Selected == 2 ? Color.red: Color.primary))
                .onTapGesture {
                    withAnimation {
                        self.Selected = 2
                    }
                   
                }
            
            TabBarIcon(width: geometry.size.width/4, height: 25, systemIconName: "person.crop.circle", iconLabel: "Account",foreground: (self.Selected == 3 ? Color.red: Color.primary))
                .onTapGesture {
                    withAnimation {
                        self.Selected = 3
                    }
                   
                }
        }}
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        
            TabView(Selected: Binding.constant(0), cartItem: 1)
            
    }
}


struct TabBarIcon: View {
    
    let width, height: CGFloat
    let systemIconName : String
    let iconLabel : String
    let foreground : Color
    
    
    
    
    var body: some View {
        VStack {
            
            Image(systemName: systemIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .padding(.top, 10)
                .foregroundColor(foreground)
            
            Text(iconLabel)
                .font(.system(size: 10))
                .bold()
                .foregroundColor(foreground)
           
        }
    }
}
