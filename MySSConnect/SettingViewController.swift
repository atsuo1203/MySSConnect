//
//  SettingViewController.swift
//  MySSConnect
//
//  Created by Atsuo Yonehara on 2017/10/06.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit
import SwiftyJSON

class SettingViewController: UIViewController {
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var blogPickerView: UIPickerView!
    @IBOutlet weak var blogNameLabel: UILabel!
    
    var blogs = [Blog]()

    override func viewDidLoad() {
        super.viewDidLoad()
        checkImageView.isUserInteractionEnabled = true
        blogPickerView.delegate = self
        blogPickerView.dataSource = self
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.checkButtonTapped))
        checkImageView.addGestureRecognizer(gesture)
        
        getBlogs()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getBlogs(){
        API.getBlog().responseJSON { (response) in
            guard let object = response.result.value else {
                return
            }
            let json = JSON(object)
            json.forEach { (_, json) in
                let blog = Blog(json: json)
                self.blogs.append(blog)
            }
            self.blogNameLabel.text = self.blogs[0].title
            self.blogPickerView.reloadAllComponents()
        }
    }
    
    func checkButtonTapped(){
        let row = blogPickerView.selectedRow(inComponent: 0)
        alert(blog: blogs[row])
    }
    
    func alert(blog: Blog){
        let alert = UIAlertController(title: "優先したブログは", message: blog.title + "です", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.blogNameLabel.text = blog.title
            RealmBlog.updateBlogID(name: "realm", id: blog.id)
        }
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
}

extension SettingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return blogs.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return blogs[row].title
    }
}
