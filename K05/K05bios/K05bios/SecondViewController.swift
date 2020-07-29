//
//  SecondViewController.swift
//  K05bios
//
//  Created by Martin Randelzofer on 19.06.20.
//  Copyright © 2020 Martin Randelzofer. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

}
