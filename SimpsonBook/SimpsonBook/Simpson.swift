//
//  Simpson.swift
//  SimpsonBook
//
//  Created by Abdulkerim Can on 30.04.2023.
//

import Foundation
import UIKit

class Simpson {
    var name : String
    var age : String
    var image : UIImage
    
    init(name: String, age: String, image: UIImage) {
        self.name = name
        self.age = age
        self.image = image
    }
    
    func introduce() -> String {
        return "My name is \(name) Simpson and I am \(age) old."
    }
}
