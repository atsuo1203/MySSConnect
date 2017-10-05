//
//  SearchViewController.swift
//  MySSConnect
//
//  Created by Atsuo Yonehara on 2017/10/02.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var tagTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //searchButton
        searchImageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.search))
        searchImageView.addGestureRecognizer(gesture)
        //textField
        self.tagTextField.delegate = self
        self.titleTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.tagTextField.isFirstResponder) {
            self.tagTextField.resignFirstResponder()
        }
        
        if (self.titleTextField.isFirstResponder) {
            self.titleTextField.resignFirstResponder()
        }
    }
    
    func search() {
        let storyboard = UIStoryboard(name: "Result", bundle: nil)
        let nextVC = storyboard.instantiateInitialViewController() as! ResultViewController
        nextVC.tag = tagTextField.text!
        nextVC.q = titleTextField.text!
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
