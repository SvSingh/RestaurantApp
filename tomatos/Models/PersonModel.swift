//
//  PersonModel.swift
//  tomatos
//
//  Created by SV Singh on 2022-02-21.				
//

import Foundation


class person : ObservableObject {
    
    @Published var Customer_name : String!
    @Published var phone : String!
    @Published var id : Int!
    @Published var email : String!
    @Published var token : String!
    @Published var password : String!
    
    
}
