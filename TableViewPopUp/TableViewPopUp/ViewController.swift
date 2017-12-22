//
//  ViewController.swift
//  TableViewPopUp
//
//  Created by UTTAM on 21/12/17.
//  Copyright © 2017 UTTAM. All rights reserved.
//

import UIKit

class ViewController: UIViewController , DoneButtonDelegate {
    
    var countries:[Country] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Show PopUp", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(showPopUp), for: .touchUpInside)
        button.frame = CGRect(x: 100, y: 100, width: 175, height: 50)
        view.addSubview(button)
        
    }
    
    @objc func showPopUp(_ sender: UIButton) {
        
        countries = [Country(name: "India") , Country(name: "Sri Lanka") , Country(name: "Nepal") , Country(name: "Pakistan") , Country(name: "Bangladesh") , Country(name: "America") , Country(name: "Japan") , Country(name: "China") , Country(name: "England")]
        let popup = CustomePopUp(frame: view.frame, list: countries)
        popup.doneButtonDelegate = self
        UIApplication.shared.keyWindow?.addSubview(popup)
    }
    
    // Delegate Method
    func didReceiveActionOnDoneButton() {
        // Applied filter here , To get the selected country
        let selectedCountry = countries.filter({$0.isSelected == true})
        for country in selectedCountry {
            print(country.name)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

