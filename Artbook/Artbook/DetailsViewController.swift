//
//  DetailsViewController.swift
//  Artbook
//
//  Created by Abdulkerim Can on 3.05.2023.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
   
    @IBOutlet weak var yearText: UITextField!
    
    @IBOutlet weak var artistText: UITextField!
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    var choosenPainting = ""
    var choosenPaintingID : UUID?

    var appDelegate : AppDelegate?
    var context : NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        context = appDelegate!.persistentContainer.viewContext
        
        if choosenPainting != "" {
            
            saveButton.isHidden = true
            
            
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            
            let idString = choosenPaintingID?.uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context!.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        if let name = result.value(forKey: "name") as? String {
                            nameText.text = name
                        }
                        if let artist = result.value(forKey: "artist") as? String {
                            artistText.text = artist
                        }

                        if let year = result.value(forKey: "year") as? Int32 {
                            yearText.text = String(year)
                        }
                        
                        if let imgData = result.value(forKey: "image") as? Data {
                            let img = UIImage(data: imgData)
                            imageView.image = img
                        }

                    }
                }
            } catch {
                print("error")
            }
            
        }else {
            saveButton.isHidden = false
            saveButton.isEnabled = false
            nameText.text = ""
            yearText.text = ""
            artistText.text = ""
        }
        //To hide keyboard we add gestureRecognizer
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        //to select image
        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecognizer)
        
    }
    
    
    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        saveButton.isEnabled = true
        self.dismiss(animated: true,completion: nil)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    
    @IBAction func saveButton(_ sender: Any) {
        
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context!)
        
        newPainting.setValue(nameText.text!, forKey: "name")
        newPainting.setValue(artistText.text!, forKey: "artist")
        
        if let year = Int(yearText.text!) {
            newPainting.setValue(year, forKey: "year")
        }
        newPainting.setValue(UUID(), forKey: "id")
        
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        
        newPainting.setValue(data, forKey: "image")
        
        do {
            try context!.save()
        } catch {
            print("error")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newData"), object: nil)
        self.navigationController?.popViewController(animated: true)
    }
}
