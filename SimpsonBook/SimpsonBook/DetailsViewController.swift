//
//  DetailsViewController.swift
//  SimpsonBook
//
//  Created by Abdulkerim Can on 30.04.2023.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var img: UIImageView!
    var simpson : Simpson?
     override func viewDidLoad() {
         super.viewDidLoad()
         age.text = simpson?.age
         name.text = simpson?.name
         img.image = simpson?.image
     }

}
