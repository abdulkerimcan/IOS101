//
//  DetailsViewController.swift
//  LandmarkBook
//
//  Created by Abdulkerim Can on 28.04.2023.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var selectedName: UILabel!
    @IBOutlet weak var selectedImage: UIImageView!
    var image = UIImage()
    var name = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedName.text = name
        selectedImage.image = image
    }
}
