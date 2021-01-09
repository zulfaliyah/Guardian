//
//  TesModel.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 08/01/21.
//

import Foundation

class TesModel: NSObject {
    //properties
        
    var id: Int?
    var fullname: String?
    var username: String?
        
    override init(){
            
    }
    
    init(id: Int, fullname: String, username: String, password: String) {
        self.id = id
        self.fullname = fullname
        self.username = username
    }

    override var description: String {
        return "id: \(String(describing: id)), Fullname: \(String(describing: fullname)), username: \(String(describing: username))"
    }
}
