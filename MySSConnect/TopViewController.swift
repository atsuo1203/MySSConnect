//
//  ViewController.swift
//  GetPostTest
//
//  Created by Atsuo Yonehara on 2017/09/25.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TopViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBAction func addButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Add", bundle: nil)
        let next = storyboard.instantiateInitialViewController() as! AddViewController
        self.present(next, animated: true, completion: nil)
    }
    @IBAction func reloadButtonTaped(_ sender: UIButton) {
        setData()
    }
    @IBOutlet weak var topTableView: UITableView!
    
    var users = Users()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //初期化
        topTableView.delegate = self
        topTableView.dataSource = self
        topTableView.estimatedRowHeight = 80
        topTableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setData()
    }
    
    func setData(){
        self.users.userList.removeAll()
        self.topTableView.reloadData()
        getRequest()
    }
    
    func getRequest(){
        Alamofire.request("http://127.0.0.1:5000/").responseJSON { (response) in
            guard let object = response.result.value else {
                return
            }
            let json = JSON(object)
            json.forEach { (_, json) in
                let user = User()
                user.id = json["id"].description
                user.name = json["name"].description
                user.description = json["description"].description
                self.users.userList.append(user)
            }
            self.topTableView.reloadData()
        }
    }
    
    func deleteRequest(id: String){
        Alamofire.request("http://127.0.0.1:5000/" + id, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response)
        }
    }
    
}

extension TopViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopCell", for: indexPath) as! TopTableViewCell
        cell.nameLabel.text = users.userList[indexPath.row].name.description
        cell.descriptionLabel.text = users.userList[indexPath.row].description.description
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // 編集
        let edit = UITableViewRowAction(style: .normal, title: "Edit") {
            (action, indexPath) in
            let storyboard = UIStoryboard(name: "Edit", bundle: nil)
            let next = storyboard.instantiateInitialViewController() as! EditViewController
            next.user = self.users.userList[indexPath.row]
            self.present(next, animated: true, completion: nil)
        }
        
        edit.backgroundColor = UIColor.green
        
        // 削除
        let del = UITableViewRowAction(style: .default, title: "Delete") {
            (action, indexPath) in
            let user = self.users.userList[indexPath.row]
            self.deleteRequest(id: user.id)
            self.users.userList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        del.backgroundColor = UIColor.red
        
        return [del, edit]
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        topTableView.setEditing(editing, animated: animated)
    }
}
