//
//  DropDownTextField.swift
//  FlipRAS
//
//  Created by Maochun Sun on 2019/9/4.
//  Copyright © 2019 Maochun Sun. All rights reserved.
//

import UIKit

protocol DropDownTextFieldDelegate{
    func dropdownListShow(sender: UIView)
}

class DropDownTextField: UIView {
    
    var delegate: DropDownTextFieldDelegate?
    var selectedCellColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
    
    lazy var itemLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        
        label.text = "test"
        //label.font = UIFont(name: "NotoSansCJKtc-Regular", size: 11)
        label.font = UIFont(name: "Arial", size: 14)
        label.textColor = UIColor(red: 0.55, green: 0.55, blue: 0.55,alpha:1)
        label.textAlignment = .left
        
        
        NSLayoutConstraint.activate([
            
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            //label.heightAnchor.constraint(equalToConstant: 11)
        ])
        
        return label
    }()
    
    lazy var inputField : UITextField = {
        let inputfield = UITextField()
        inputfield.translatesAutoresizingMaskIntoConstraints = false
        inputfield.isUserInteractionEnabled = true
        
        
        inputfield.backgroundColor = .white
        inputfield.layer.cornerRadius = 5
        inputfield.layer.borderColor = UIColor(red: 0.22, green: 0.8, blue: 0.85, alpha: 1).cgColor
            
        inputfield.font = UIFont(name: "NotoSansCJKtc-Regular", size: 16)
        inputfield.textColor = UIColor(red: 0.18, green: 0.18, blue: 0.18,alpha:1)
        inputfield.layer.borderWidth = 1
        inputfield.layer.masksToBounds = true
        inputfield.setLeftPaddingPoints(10)
        
        inputfield.delegate = self
        inputfield.addTarget(self,  action: #selector(dropdownAction), for: .touchDown)
        
        self.addSubview(inputfield)
        
        NSLayoutConstraint.activate([
            
            inputfield.topAnchor.constraint(equalTo: self.topAnchor, constant: 19),
            inputfield.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            inputfield.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -32),
            inputfield.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        return inputfield
        
    }()
    
    lazy var droplistButton: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.setBackgroundImage(UIImage(named: "select_icon_arrow"), for: .normal);
        btn.setBackgroundImage(UIImage(named: "select_icon_arrow"), for: .selected);
        

        btn.addTarget(self, action: #selector(dropdownAction), for: .touchUpInside)
        
        self.addSubview(btn)
        
        NSLayoutConstraint.activate([
            
            btn.centerYAnchor.constraint(equalTo: self.inputField.centerYAnchor),
            btn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -32)
            
        ])
        
        return btn
    }()
    
    
    lazy var listTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x:self.frame.origin.x + 16, y:self.frame.origin.y + 60, width: self.inputField.frame.width-32, height: 300), style: .grouped)
        
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableView.automaticDimension
        //tableView.borderWidth = 1.0
        tableView.backgroundColor = .white
        tableView.tableHeaderView = nil
        tableView.contentInset = UIEdgeInsets(top: -30, left: 0, bottom: 0, right: 0);
        tableView.separatorStyle = .none
        //tableView.isEditing = true
        
        //tableView.allowsMultipleSelection = true
        //tableView.roundCorners(.allCorners, radius: 2.0)
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DropdownListTableCell")
        
        tableView.layer.borderColor = UIColor(red: 0.22, green: 0.8, blue: 0.85, alpha: 1).cgColor
        tableView.layer.borderWidth = 1
        tableView.layer.masksToBounds = true
        //tableView.round(corners: [.bottomLeft, .bottomRight], radius: 5)

        //tableView.isHidden = true
        
        //self.addSubview(tableView)
        
        /*
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: self.inputField.bottomAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: self.inputField.leftAnchor, constant: 0),
            tableView.widthAnchor.constraint(equalToConstant: self.inputField.viewwidth - 32),
            tableView.heightAnchor.constraint(equalToConstant: 300)
            
        ])
        */
        
        
        return tableView
    }()
    
    var items = [String]()
    var dropdownListShow = false
    var enableDropdownList = true
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    
    init(items: [String]) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        var _ = self.itemLabel
        var _ = self.inputField
        var _ = self.droplistButton
        
        //self.backgroundColor = .blue
        
        if items.count > 0{
            self.inputField.text = items[0]
            
            self.items = items
        }
        
        
    }
    
    func setEnable(enable: Bool){
        self.inputField.isEnabled = enable
        self.droplistButton.isEnabled = enable
    }
    
    
    
    @objc func dropdownAction(){
        
        if !self.enableDropdownList{
            return
        }
        
        if self.dropdownListShow == false{
            //self.frame.size.height += 300
            
            //self.listTableView.isHidden = false
            
            self.delegate?.dropdownListShow(sender: self)
            
            if items.count > 7{
                self.listTableView.frame.size.height = 300
            }else{
                self.listTableView.frame.size.height = CGFloat(items.count * 40) + 20
            }
            
            self.superview?.addSubview(self.listTableView)
            //self.addSubview(listTableView)
            self.listTableView.reloadData()
            

        }else{
            self.listTableView.removeFromSuperview()
        }
        
        self.dropdownListShow = !self.dropdownListShow
    }
    
    func hideList(){
        if self.dropdownListShow{
            self.listTableView.removeFromSuperview()
            self.dropdownListShow = false
        }
    }
    
}

extension DropDownTextField: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier:"DropdownListTableCell", for:indexPath)
        
        cell.textLabel?.text = self.items[indexPath.row]
        cell.textLabel?.textColor = .gray
        cell.backgroundColor = .white

        let idx = items.firstIndex(of: self.inputField.text!)
        
        if indexPath.row == idx{
            cell.backgroundColor = self.selectedCellColor
            cell.accessoryType = .checkmark
            cell.accessoryView = UIImageView(image: UIImage(named: "list_icon_check"))
        }else{
            cell.accessoryType = .none
            cell.accessoryView = nil
        }
        
        return cell
        
    }
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Add a visual cue to indicate that the cell was selected.
        self.inputField.text = items[indexPath.row]
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        tableView.cellForRow(at: indexPath)?.accessoryView = UIImageView(image: UIImage(named: "list_icon_check"))
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.cellForRow(at: indexPath)?.backgroundColor = self.selectedCellColor
        
        self.listTableView.removeFromSuperview()
        self.dropdownListShow = false
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        
        let idx = IndexPath(row: (items.firstIndex(of: self.inputField.text!))!, section: 0)
        
        tableView.cellForRow(at: idx)?.accessoryType = .none
        tableView.cellForRow(at: idx)?.accessoryView = nil
        tableView.cellForRow(at: idx)?.backgroundColor = .white
        
        return indexPath
    }
}

extension DropDownTextField: UITextFieldDelegate{
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}
