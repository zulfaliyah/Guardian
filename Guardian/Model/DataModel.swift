//
//  DataModel.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 08/01/21.
//

import Foundation

protocol DataModelProtocol: class {
    func itemsDownloaded(items: NSArray)
}


class DataModel: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: DataModelProtocol!
    
    let urlPath = "http://localhost:3000/api/v1/admin/allusers"
 
    func downloadItems() {
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("Data downloaded")
                self.parseJSON(data!)
            }
            
        }
        
        task.resume()
    }
    
    func parseJSON(_ data:Data) {
            
            var jsonResult = NSArray()
            
            do{
                jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
                
            } catch let error as NSError {
                print(error)
                
            }
            
            var jsonElement = NSDictionary()
            let data = NSMutableArray()
            
            for i in 0 ..< jsonResult.count
            {
                
                jsonElement = jsonResult[i] as! NSDictionary
                
                let tesModel = TesModel()
                
                //the following insures none of the JsonElement values are nil through optional binding
                if let id = jsonElement["id"] as? Int,
                    let fullname = jsonElement["Fullname"] as? String,
                    let username = jsonElement["Username"] as? String
                {
                    
                    tesModel.id = id
                    tesModel.fullname = fullname
                    tesModel.username = username
                    
                }
                
                data.add(tesModel)
                
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                
                self.delegate.itemsDownloaded(items: data)
                
            })
        }
}
