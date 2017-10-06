//
//  SettingViewController.swift
//  MySSConnect
//
//  Created by Atsuo Yonehara on 2017/10/06.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var blogPickerView: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        checkImageView.isUserInteractionEnabled = true
        blogPickerView.delegate = self
        blogPickerView.dataSource = self
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.checkButtonTapped))
        checkImageView.addGestureRecognizer(gesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func checkButtonTapped(){
        print("check is tapped")
    }
}

extension SettingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "aaa"
    }
}
