

import Foundation
import UIKit


struct Menu : Codable, Identifiable {
    
    var id : Int
    var Item : String
    var price : String
    var sold : Int?
    var left : Int?
    var GST : Bool
    var PLT : Bool
    var PST : Bool
    var category_id : Int
    var Discription : String
}


class MenuInitialize {
    
    var menuItems = [Menu]()
    
    init()   {
        
        
        
        let url = URL(string: "http://192.168.1.80:8000/api/menu")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        
        
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            if let data = data {
                
                do {
                    let decoder = JSONDecoder()
                    
                    
                    let Results = try decoder.decode([Menu].self, from: data)
                    DispatchQueue.main.async {
                        self.menuItems = Results
                    }
                }
                
                catch {
                    print (error)
                }
                
                
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        
        task.resume()
        
        
        
        
        
    }
    
    func fetchMenu(category : Int) -> [Menu]{
        
        var result = [Menu]()
        
        for menu in menuItems {
            
            if menu.category_id == category {
                result.append(menu)
            }
            
        }
        
        
        
        return result
        
    }
    
    
    
}
