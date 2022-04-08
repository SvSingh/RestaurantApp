//
//  AccountView.swift
//  tomatos
//
//  Created by SV Singh on 2022-02-16.
//

import SwiftUI

struct AccountInfoView: View {
     var body: some View {
        ZStack {
            
            backView()
            
            VStack() {
                  HStack {
                    Spacer()
                    Button {
                        let domain = Bundle.main.bundleIdentifier!
                        UserDefaults.standard.removePersistentDomain(forName: domain)
                        UserDefaults.standard.synchronize()
                        AppState.shared.gameID = UUID()
                    } label: {
                        Text("Log Out")
                            .frame(width: 80,alignment: .trailing)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                            .font(.system(size: 20,weight : .bold))
                            .foregroundColor(Color.white)
                            .shadow(color:Color.red.opacity(0.5),radius : 5,x : 0, y : 10)
                    }
                }.padding(.horizontal,10)
                
               
                PersonDetailsView().frame( height: 470)
                
            }.padding()
                
        }
        
        
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountInfoView()
    }
}

struct PersonDetailsView: View {
    
    @State var userDefault = UserDefaults.standard
    @State var id : Int =  0
    @State var Name : String = ""
    @State var Email : String = ""
    @State var Phone : String = ""
   
    
    @State var errorMessage = ""
    @State var showingAlert = false
    
   func onAppearTask(){
        
       
        id = userDefault.object(forKey: "id") as? Int ?? 0
        Email = userDefault.object(forKey: "email") as? String ?? ""
        Phone = userDefault.object(forKey: "phone") as? String ?? ""
        Name = userDefault.object(forKey: "name") as? String ?? ""
       
      
        
        
    }
    
    
    var body: some View {
        ScrollView{
            
            VStack{
                VStack(alignment: .leading){
                    Text("Name")
                    Text(self.Name)
                        .frame(width: 300)
                        .padding()
                        .foregroundColor(Color.black)
                        .background(Color.white)
                        .cornerRadius(10)
                    
                }.padding()
                    .background( Color.primary.opacity(0.1)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                 
                        .frame(maxWidth : .infinity))
                
                
                VStack(alignment: .leading){
                    Text("Email")
                    Text(self.Email)
                        .frame(width: 300)
                        .padding()
                        .foregroundColor(Color.black)
                        .background(Color.white)
                        .cornerRadius(10)
                    
                }.padding()
                    .background( Color.primary.opacity(0.1)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                 
                        .frame(maxWidth : .infinity))
                
                VStack(alignment: .leading){
                    Text("Phone Number")
                    Text(self.Phone)
                        .frame(width: 300)
                        .padding()
                        .foregroundColor(Color.black)
                        .background(Color.white)
                        .cornerRadius(10)
                    
                }.padding()
                    .background( Color.primary.opacity(0.1)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                 
                        .frame(maxWidth : .infinity))
                
               
                
                
            }
        }
        
            .onAppear {
                onAppearTask()
                
            }
    }
}
