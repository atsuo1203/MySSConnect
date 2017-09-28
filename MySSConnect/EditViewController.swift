//
//  EditViewController.swift
//  GetPostTest
//
//  Created by Atsuo Yonehara on 2017/09/26.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EditViewController: UIViewController {
    @IBAction func backButtonTaped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func sendButtonTaped(_ sender: UIButton) {
        putRequest(userID: (idLabel.text?.description)!, name: (nameTextField.text?.description)!, description: descriptionTextView.text)
        print(idLabel.text!)
        print(nameTextField.text!)
        print(descriptionTextView.text)
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
    
    func putRequest(userID: String, name: String, description: String){
        let parameters: Parameters = [
            "name": name,
            "description": description
        ]
        Alamofire.request("http://127.0.0.1:5000/" + userID, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response)
            //print(response.value ?? "no response")
        }
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
