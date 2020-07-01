//
//  ViewController.swift
//  DropdownListSample
//
//  Created by Maochun Sun on 2020/7/1.
//  Copyright © 2020 Maochun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    lazy var theDropdownTxtField : DropDownTextField = {
        var itemArr = [String]()
        for i in 0 ..< 10{
            itemArr.append("Item \(i+1)")
        }
        
        let dropdownTxt = DropDownTextField(items:itemArr)
        dropdownTxt.enableDropdownList = true
        dropdownTxt.translatesAutoresizingMaskIntoConstraints = false
        dropdownTxt.delegate = self
        dropdownTxt.itemLabel.text = "Select item:"
        self.view.addSubview(dropdownTxt)
        
        NSLayoutConstraint.activate([
            dropdownTxt.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            dropdownTxt.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 68),
            
            dropdownTxt.widthAnchor.constraint(equalToConstant: 350),
            dropdownTxt.heightAnchor.constraint(equalToConstant: 75)
            
        ])
        
        
        return dropdownTxt
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let _ = self.theDropdownTxtField
    }


}

extension ViewController: DropDownTextFieldDelegate{
    
    func dropdownListShow(sender: UIView){
        print("dropdown list show")
    }
}
