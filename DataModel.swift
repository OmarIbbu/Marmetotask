//
//  DataModel.swift
//  Marmeto
//
//  Created by thincnext on 27/09/18.
//  Copyright © 2018 thincnext. All rights reserved.
//

import Foundation
class DataModel {
  
    var name: String
    var phone: String
    var location: String
    var address: String
    
    init(name: String, phone: String, location: String,address: String){
        self.name = name
        self.phone = phone
        self.location = location
        self.address = address
    }
}
