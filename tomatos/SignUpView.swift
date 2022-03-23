//
//  SignUpView.swift
//  tomatos
//
//  Created by SV Singh on 2022-03-17.
//

import SwiftUI

struct SignUpView: View {
    
    @State var userDefault = UserDefaults.standard
    @State var Name : String = ""
    @State var Email : String = ""
    @State var Phone : String = ""
    @State var Password : String = ""
    @State var RePassword : String = ""
    var body: some View {
        
        backView()
            .overlay(
                
                
                VStack {
                    
                    VStack(alignment: .leading){
                        Text("Name")
                        TextField("name", text: self.$Name)
                            .padding()
                            .foregroundColor(Color.black)
                            .background(Color.white)
                            .cornerRadius(10)
                        
                    }
                    VStack(alignment: .leading){
                        Text("Email")
                        TextField("Email", text: self.$Email)
                            .padding()
                            .foregroundColor(Color.black)
                            .background(Color.white)
                            .cornerRadius(10)
                        
                    }
                    VStack(alignment: .leading){
                        Text("Phone Number")
                        TextField("Phone Number", text: self.$Phone)
                            .padding()
                            .foregroundColor(Color.black)
                            .background(Color.white)
                            .cornerRadius(10)
                        
                    }
                    VStack(alignment: .leading){
                        Text("Password")
                        TextField("Password", text: self.$Password)
                            .padding()
                            .foregroundColor(Color.black)
                            .background(Color.white)
                            .cornerRadius(10)
                        
                    }
                    
                    VStack(alignment: .leading){
                        Text("Re Enter Password")
                        TextField("re-Password", text: self.$RePassword)
                            .padding()
                            .foregroundColor(Color.black)
                            .background(Color.white)
                            .cornerRadius(10)
                        
                    }
                   
                 Spacer()
                    
                    Button{}label: {
                        
                        Text("Sign Up")
                            .frame(width: 350,height: 50)
                            .padding(.horizontal,10)
                            .background(Color.red)
                            .cornerRadius(10)
                            .font(.system(size: 20,weight : .bold))
                            .foregroundColor(Color.white)
                            .shadow(color:Color.red.opacity(0.5),radius : 5,x : 0, y : 10)
                    }
                    
                }.padding()
        )
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SignUpView()
           
        }
    }
}
