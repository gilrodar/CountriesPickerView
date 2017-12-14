//
//  ViewController.swift
//  CountriesPickerView
//
//  Created by Gil Rodarte on 13/12/17.
//  Copyright © 2017 Gil Rodarte. All rights reserved.
//

import UIKit

struct Country:Decodable {
    let name: String
}

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countriesPickerView: UIPickerView!
    
    var countries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countriesPickerView.delegate = self
        countriesPickerView.dataSource = self
        
        let url = URL(string: "https://restcountries.eu/rest/v2/all/")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                    self.countries = try JSONDecoder().decode([Country].self, from: data!)
                }catch {
                    print("Parse Error")
                }
                DispatchQueue.main.async {
                    self.countriesPickerView.reloadComponent(0)
                }
            }
        }.resume()
    }

    //Metodos para el Picker View
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row].name
    }
    
    //Cambiar el texto del Label
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCountry = countries[row].name
        countryLabel.text = selectedCountry
    }
}

