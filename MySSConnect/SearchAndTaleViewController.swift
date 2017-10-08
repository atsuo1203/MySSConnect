//
//  TagViewController.swift
//  MySSConnect
//
//  Created by Atsuo Yonehara on 2017/10/02.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit
import SwiftyJSON

enum MyController {
    case tag
    case favorite
    init() {
        self = .tag
    }
}

class SearchAndTableViewController: UIViewController {
    @IBOutlet weak var mainSearchBar: UISearchBar!
    @IBOutlet weak var mainTableView: UITableView!
    var tags = [Tag]()
    var tagsResult = [Tag]()
    var stories = [RealmStory]()
    var storiesResult = [RealmStory]()
    var type = MyController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        //searchBar
        self.mainSearchBar.delegate = self
        self.mainSearchBar.enablesReturnKeyAutomatically = false
        //tag取得
        //tagBarかfavoriteBarかで処理を分離
        if self.title! == "Tag" {
            type = .tag
            self.mainTableView.register(UINib(nibName: "TagCell", bundle: nil), forCellReuseIdentifier: "TagCell")
            getTags()
        }
        if self.title! == "Favorite" {
            type = .favorite
            self.mainTableView.register(UINib(nibName: "MainCell", bundle: nil), forCellReuseIdentifier: "MainCell")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func getTags(){
        API.getTags().responseJSON { (response) in
            guard let object = response.result.value else {
                return
            }
            let json = JSON(object)
            json.forEach { (_, json) in
                let tag = Tag(json: json)
                if tag.taggings_count != 0 {
                    self.tags.append(tag)
                }
            }
            self.tagsResult = self.tags
            self.mainTableView.reloadData()
        }
    }
}

extension SearchAndTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch type {
        case .tag:
            return tagsResult.count
        case .favorite:
            return storiesResult.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell", for: indexPath) as! TagTableViewCell
        cell.selectionStyle = .none
        cell.nameLabel.text = tagsResult[indexPath.row].name
        cell.countLabel.text = "(" + tagsResult[indexPath.row].taggings_count.description + ")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Result", bundle: nil)
        let nextVC = storyboard.instantiateInitialViewController() as! ResultViewController
        nextVC.tag = tagsResult[indexPath.row].name
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension SearchAndTableViewController: UISearchBarDelegate {
    //searchBarで検索した時の処理
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        mainSearchBar.endEditing(true)
        tagsResult.removeAll()
        
        if(mainSearchBar.text == "") {
            tagsResult = tags
        } else {
            for tag in tags {
                if tag.name.contains(mainSearchBar.text!) {
                    tagsResult.append(tag)
                }
            }
        }
        self.mainTableView.reloadData()
    }
}
