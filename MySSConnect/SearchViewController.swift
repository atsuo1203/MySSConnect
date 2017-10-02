//
//  SearchViewController.swift
//  MySSConnect
//
//  Created by Atsuo Yonehara on 2017/10/02.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var searchImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchImageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.search))
        searchImageView.addGestureRecognizer(gesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func search() {
        let storyboard = UIStoryboard(name: "Result", bundle: nil)
        guard let nextVC = storyboard.instantiateInitialViewController() else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
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
