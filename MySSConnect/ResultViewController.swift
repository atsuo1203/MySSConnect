//
//  ResultViewController.swift
//  MySSConnect
//
//  Created by Atsuo Yonehara on 2017/10/02.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit
import SwiftyJSON

class ResultViewController: UIViewController {
    @IBOutlet weak var mainTableView: UITableView!
    //受け取るやつ
    var tag = ""
    var q = ""
    //HomeViewControllerとして使われているかどうか
    var isHomeViewController = Bool()
    //page
    var page = 1
    var lastPage = 1000
    
    var stories = [Story]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.mainTableView.register(UINib(nibName: "MainCell", bundle: nil), forCellReuseIdentifier: "MainCell")
        self.mainTableView.register(UINib(nibName: "AddCell", bundle: nil), forCellReuseIdentifier: "AddCell")
        self.mainTableView.estimatedRowHeight = 90
        self.mainTableView.rowHeight = UITableViewAutomaticDimension
        if q == "" {
            self.navigationItem.title = tag
        } else {
            self.navigationItem.title = tag + "・" + q
        }
        if isHomeViewController {
            self.navigationItem.title = "Home"
        }
        getStories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getStories(){
        self.stories.removeAll()
        API.getStories(tag: tag, q: q, page: page.description).responseJSON { (response) in
            guard let object = response.result.value else {
                return
            }
            let json = JSON(object)
            json.forEach { (_, json) in
                let story = Story(json: json)
                self.stories.append(story)
            }
            self.mainTableView.reloadData()
        }
    }
    
}

extension ResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCell", for: indexPath) as! AddTableViewCell
            cell.selectionStyle = .none
            cell.addLabel.text = "前のページへ"
            if page == 1 {
                cell.addLabel.textColor = UIColor.lightGray
            } else {
                cell.addLabel.textColor = UIColor.blue
            }
            cell.selectionStyle = .none
            return cell
        } else if (indexPath.row < stories.count + 1) && (indexPath.row > 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainTableViewCell
            cell.selectionStyle = .none
            cell.titleLabel?.text = stories[indexPath.row - 1].title
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCell", for: indexPath) as! AddTableViewCell
            cell.selectionStyle = .none
            cell.addLabel.text = "次のページへ"
            if page == lastPage {
                cell.addLabel.textColor = UIColor.lightGray
            } else {
                cell.addLabel.textColor = UIColor.blue
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
           self.page -= 1
            getStories()
        } else if (indexPath.row < stories.count + 1) && (indexPath.row > 0) {
            //押されたcellを取得
            let cell = tableView.cellForRow(at: indexPath) as! MainTableViewCell
            //何番目が押されたかを取得
            guard let row = self.mainTableView.indexPath(for: cell)?.row else {
                return
            }
            API.showWebView(viewController: self, targetURL: stories[row - 1].articles[0].url)
        } else {
            self.page += 1
            getStories()
        }
    }
}
