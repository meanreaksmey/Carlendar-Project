//
//  DetailViewController.swift
//  Calendar-Project
//
//  Created by Mean Reaksmey on 10/18/16.
//  Copyright © 2016 reaksmey. All rights reserved.
//

import UIKit
import FontAwesomeKit

class DetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Events"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title:"Add", style: .plain, target: self, action: #selector(self.startAction))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func startAction() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let nvc = UINavigationController(rootViewController: vc)
        nvc.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present (nvc, animated: true, completion: nil)
        
    }
    
}
