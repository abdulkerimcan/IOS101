//
//  ViewController.swift
//  SimpsonBook
//
//  Created by Abdulkerim Can on 30.04.2023.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {


    @IBOutlet weak var tableview: UITableView!
    var characters = [Simpson]()
    var choosenSimpson : Simpson?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        
        characters.append(Simpson(name: "Homer", age: "39", image: UIImage(named:  "homer")!))
        characters.append(Simpson(name: "Marge", age: "37", image: UIImage(named:  "marge")!))
        characters.append(Simpson(name: "Bart", age: "10", image: UIImage(named: "bart")!))
        characters.append(Simpson(name: "Lisa", age: "8", image: UIImage(named: "lisa")!))
        characters.append(Simpson(name: "Maggie", age: "1", image: UIImage(named: "maggie")!))
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = characters[indexPath.row].name
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        choosenSimpson = characters[indexPath.row]
        
        self.performSegue(withIdentifier: "toDetails", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails" {
            let destination = segue.destination as! DetailsViewController
            destination.simpson = self.choosenSimpson
            
        }
    }
}

