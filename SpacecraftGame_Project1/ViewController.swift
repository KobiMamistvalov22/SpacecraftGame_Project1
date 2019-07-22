//
//  ViewController.swift
//  SpacecraftGame_Project1
//
//  Created by Kobi Mamistvalov on 7/22/19.
//  Copyright © 2019 Kobi Mamistvalov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var name = ""
    var userNameLbl: UILabel!
    var headerlbl: UILabel!
    var textfieldName: UITextField!
    var login: UIButton!
    var seconde: SecondeView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerlbl = UILabel(frame: CGRect(x: 0, y: 120, width: 200, height: 40))
        headerlbl.text = "Wellcome Guest"
        headerlbl.font = UIFont.boldSystemFont(ofSize: 25)
        headerlbl.center.x = view.center.x
        
        textfieldName = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        textfieldName.borderStyle = .roundedRect
        textfieldName.placeholder = "Name"
        textfieldName.center = view.center
        
        userNameLbl = UILabel(frame: CGRect(x: textfieldName.frame.minX, y: textfieldName.frame.minY - textfieldName.frame.height - 5, width: 200, height: 40))
        userNameLbl.text = "Enter your name:"
        userNameLbl.font = UIFont.boldSystemFont(ofSize: 20)
        
        view.addSubview(userNameLbl)
        view.addSubview(textfieldName)
        view.addSubview(headerlbl)
        
        login = UIButton(type: .system)
        login.frame = CGRect(x: textfieldName.frame.maxX / 2, y: textfieldName.frame.maxY + 5, width: 100, height: 35)
        login.setTitle("Done!", for: .normal)
        login.addTarget(self, action: #selector(handlebtncliced(sendr:)), for: .touchUpInside)
        view.addSubview(login)
    }
    
    @objc func handlebtncliced(sendr: UIButton){
        
        name = textfieldName.text!
        if name.isEmpty{
            let worning = UILabel(frame: CGRect(x: 20, y: login.frame.maxY + 5, width: 350, height: 20))
            worning.textColor = .red
            worning.text = "You not registered a name or password!"
            view.addSubview(worning)
        }
        else{
            if self.seconde == nil {
                self.seconde = SecondeView()
                self.seconde!.mainViewController = self
            }
            self.present(self.seconde!, animated: true, completion: nil)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
        
    }
}


