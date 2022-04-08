//
//  LoginView.swift
//  tomatos
//
//  Created by SV Singh on 2022-02-15.
//

import SwiftUI

struct LoginView: View {
    
    
    
    func onAppearTASK() {
        
        
        if(userDefault.object(forKey: "APIKEY") != nil){
            
            customer.token = userDefault.object(forKey: "APIKEY") as? String
            customer.email = userDefault.object(forKey: "email") as? String
            customer.password = userDefault.object(forKey: "Password") as? String
            customer.id = userDefault.object(forKey: "id") as? Int
            customer.phone = userDefault.object(forKey: "phone") as? String
            customer.Customer_name = userDefault.object(forKey: "name") as? String
            
            
        }
        
        else {
            
            customer.token = nil
            customer.email = nil
            customer.password = nil
            customer.id = nil
            customer.phone = nil
            customer.Customer_name = nil
            
        }
        
        
        
        
    }
    
    
    
    
    @State var showContentView = true
    
    @State  var userDefault = UserDefaults.standard
    
    
    @ObservedObject var customer = person()
    
    
    
    
    var body: some View {
        NavigationView{
            ZStack {
                backView()
                
                
                if(customer.token == nil){
                    
                    ExtractedView()
                        
                    
                }
                else{
                    NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true)
                                    .navigationBarTitle("")
                                    .navigationBarHidden(true)
                                    
                                    
                                   , isActive: $showContentView) {
                        Text("")
                        
                    }.hidden()
                }
                
                
            }
            
            
            
        }
        
        .onAppear {
            onAppearTASK()
        }
        
        
        
    }
    
    
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct ExtractedView: View {
    
    
    
    @State var showContentView = true
    
    @State var email = "test@mail.com"
    @State var password = "svsingh2320"
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            
            Spacer()
            
            Image("TomatoLogo").resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height:70)
                .shadow(radius: 10)
            
            Spacer()
            
            Text("Welcome Back")
                .fontWeight(.bold)
                .foregroundColor(Color.primary)
            
            Spacer()
            VStack {
                VStack {
                    Text("Please Enter Your Email")
                    TextField("Email", text: self.$email)
                        .padding()
                        .foregroundColor(Color.black)
                        .background(Color.white)
                    .cornerRadius(10)
                }
                VStack {
                    Text("Please Enter Your Password")
                    SecureField("Password", text: self.$password)
                        .padding()
                        .foregroundColor(Color.black)
                        .background(Color.white)
                    .cornerRadius(10)
                }
            }
            
            Button(action: {
                
                let loginmodel = LoginModel()
                
                loginmodel.SignIn(credentials: loginCredentials(email: self.email, password: self.password))
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    AppState.shared.gameID = UUID()
                })
            }) {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 350, height: 50)
                    .background(Color.green)
                    .cornerRadius(15.0)
            }
            Spacer()
            Spacer()
            
            HStack {
                Text("Don't Have an Account yet?")
                
                NavigationLink(destination: SignUpView().navigationBarBackButtonHidden(false)
                            ) {
                    Text("Sign up!")
                    
                }
            }
            
        }.padding()
    }
}
