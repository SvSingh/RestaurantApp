

import Foundation


struct Category : Codable ,Identifiable{
    
    var id : Int
    var  name : String
    
    
    
}

class categoryInitialize {
    
    
    var category = [Category]()
    
    
    func initialize (){
        
        let url = URL(string: "https://tomatos.ca/Laravel/api/Category")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            if let data = data {
                
                do {
                    let decoder = JSONDecoder()
                    let Results = try decoder.decode([Category].self, from: data)
                    
                    DispatchQueue.main.async {
                        self.category  = Results
                       
                        self.category.remove(at: 13)
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
    
}
