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

    override func viewDidLoad() {
        super.viewDidLoad()
        checkImageView.isUserInteractionEnabled = true
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
