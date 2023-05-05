//
//  ViewController.swift
//  Currency Coverter
//
//  Created by Abdulkerim Can on 5.05.2023.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    let currencies = ["usd","eur","jpy","try"]
    var selectedCurrency = ""
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var euro: UILabel!
    @IBOutlet weak var turkish: UILabel!
    @IBOutlet weak var jpy: UILabel!
    @IBOutlet weak var usd: UILabel!
    @IBOutlet weak var pickerview: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerview.delegate = self
        pickerview.dataSource = self
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        selectedCurrency = currencies[row]
        return currencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCurrency = currencies[row]
    }
    @IBAction func convertButtonClick(_ sender: Any) {
        
        let url = "https://api.apilayer.com/fixer/latest?symbols=&base=\(selectedCurrency.uppercased())"
        
        let apiKey = "csXlAS4F7AahdN7cMzdWh5kDTvqzlQYJ"
        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "apikey")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default,handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else {
                if data != nil {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!,options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>
                        
                        DispatchQueue.main.async {
                            
                            if let rates = jsonResponse["rates"] as? [String : Double] {
                               
                                if let price = Double(self.priceTextField.text!) {
                                    if let usd = rates["USD"] {
                                        self.usd.text = "USD : \(usd * price)"
                                        print(usd)
                                    }
                                    if let turk = rates["TRY"] {
                                        self.turkish.text = "TRY : \(turk * price)"
                                    }
                                    if let euro = rates["EUR"] {
                                        self.euro.text = "EUR : \(euro * price)"
                                    }
                                    if let jpy = rates["JPY"] {
                                        self.jpy.text = "JPY : \(jpy * price)"
                                    }
                                }
                            }
                            
                        }
                    }catch {
                        print("error")
                    }
                }
            }
        }
        
        task.resume()
    }
}

