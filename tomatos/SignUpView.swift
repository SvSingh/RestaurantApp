//
//  SignUpView.swift
//  tomatos
//
//  Created by SV Singh on 2022-03-17.
//

import SwiftUI
import iPhoneNumberField

struct SignUpView: View {
    
    @State var userDefault = UserDefaults.standard
    @State var Name : String = ""
    @State var Email : String = ""
    @State var Phone : String = ""
    @State var Password : String = ""
    @State var RePassword : String = ""
    
    
    @State var showingAlert = false
    
    @State var errorMessage = ""
    
    func isValidPhoneNumber(value: String) -> Bool {
        let PHONE_REGEX = "^[0-9]{6,14}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
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
                        //iPhoneNumberField("Phone Number", text: self.$Phone)
                          //  .flagHidden(false)
                            //.flagSelectable(true)
                        TextField("Phone", text: self.$Phone)
                            .padding()
                            .accentColor(Color.black)
                            .background(Color.white)
                            .cornerRadius(10)
                        
                    }
                    VStack(alignment: .leading){
                        Text("Password")
                        SecureField("Password", text: self.$Password)
                            .padding()
                            .foregroundColor(Color.black)
                            .background(Color.white)
                            .cornerRadius(10)
                        
                    }
                    
                    VStack(alignment: .leading){
                        Text("Re Enter Password")
                        SecureField("re-Password", text: self.$RePassword)
                            .padding()
                            .foregroundColor(Color.black)
                            .background(Color.white)
                            .cornerRadius(10)
                        
                    }
                   
                 Spacer()
                    
                    Button{
                        
                        if(self.Name == ""){
                            self.errorMessage = "Please enter a valid name."
                            self.showingAlert = true
                        }
                        else if (!isValidEmail(self.Email)){
                            self.errorMessage = "Please enter a valid Email."
                            self.showingAlert = true
                        }
                       else if (!isValidPhoneNumber(value: self.Phone)){
                            self.errorMessage = "please enter a valid Phone Number."
                            self.showingAlert = true
                        }
                        else if (self.Password == "" || self.RePassword == ""){
                            self.errorMessage = "Please enter your passwords"
                            self.showingAlert = true
                        }
                        else if (self.RePassword != self.RePassword){
                            self.errorMessage = "Your Passwords Does not match."
                            self.showingAlert = true
                        }
                        else {
                            let SignUp = signup()
                            
                            SignUp.signupDetail.Customer_name = self.Name
                            SignUp.signupDetail.email = self.Email
                            SignUp.signupDetail.password = self.Password
                            SignUp.signupDetail.password_confirmation = self.RePassword
                            SignUp.signupDetail.phone_number = self.Phone
                            
                            print(SignUp.signupDetail)
                           
                            SignUp.signup()
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                                if(SignUp.Success){
                                    AppState.shared.gameID = UUID()
                                }
                                else if (SignUp.error) {
                                    self.errorMessage = "The Email Already Exist. Please try to Sign in."
                                    self.showingAlert = true
                                }
                                
                            })
                        }
                        
                        
                        
                        
                    }label: {
                        
                        Text("Sign Up")
                            .frame(width: 350,height: 50)
                            .padding(.horizontal,10)
                            .background(Color.red)
                            .cornerRadius(10)
                            .font(.system(size: 20,weight : .bold))
                            .foregroundColor(Color.white)
                            .shadow(color:Color.red.opacity(0.5),radius : 5,x : 0, y : 10)
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Error Message"), message: Text(self.errorMessage), dismissButton: .default(Text("Got it!")))
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
