//
//  EditViewController.swift
//  GetPostTest
//
//  Created by Atsuo Yonehara on 2017/09/26.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    @IBAction func backButtonTaped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func sendButtonTaped(_ sender: UIButton) {
        API.putRequest(userID: idLabel.text!, name: nameTextField.text!, description: descriptionTextView.text!)
        print(idLabel.text!)
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!

    @IBOutlet weak var descriptionTextView: UITextView!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let u = user else {
            return
        }
        
        idLabel.text = u.id
        nameLabel.text = u.name
        descriptionLabel.text = u.description

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
