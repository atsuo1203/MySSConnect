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
            self.mainTableView.estimatedRowHeight = 90
            self.mainTableView.rowHeight = UITableViewAutomaticDimension
            self.mainTableView.register(UINib(nibName: "MainCell", bundle: nil), forCellReuseIdentifier: "MainCell")
            getStories()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch type {
        case .tag:
            print("hello")
        case .favorite:
            getStories()
        }
    }
    
    func getTags() {
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
    
    func getStories() {
        self.stories = RealmStory.getAllFilterBlogID()
        self.storiesResult = self.stories
        self.mainTableView.reloadData()
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
        switch type {
        case .tag:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell", for: indexPath) as! TagTableViewCell
            cell.selectionStyle = .none
            cell.nameLabel.text = tagsResult[indexPath.row].name
            cell.countLabel.text = "(" + tagsResult[indexPath.row].taggings_count.description + ")"
            return cell
        case .favorite:
            let story = storiesResult[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainTableViewCell
            cell.selectionStyle = .none
            cell.titleLabel.text = story.title.description
            cell.dateLabel.text = story.data.description
            cell.blogLabel.text = story.blog_name.description
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch type {
        case .tag:
            let storyboard = UIStoryboard(name: "Result", bundle: nil)
            let nextVC = storyboard.instantiateInitialViewController() as! ResultViewController
            nextVC.tag = tagsResult[indexPath.row].name
            self.navigationController?.pushViewController(nextVC, animated: true)
        case .favorite:
            API.showWebView(viewController: self, targetURL: storiesResult[indexPath.row].url)
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        switch type {
        case .tag:
            return []
        case .favorite:
            //お気に入り追加
            let edit = UITableViewRowAction(style: .default, title: "削除") {
                (action, indexPath) in
                RealmStory.delete(entry: self.storiesResult[indexPath.row])
                self.getStories()
            }
            edit.backgroundColor = UIColor.red
            return [edit]
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        mainTableView.setEditing(editing, animated: animated)
    }
}

extension SearchAndTableViewController: UISearchBarDelegate {
    //searchBarで検索した時の処理
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        mainSearchBar.endEditing(true)
        switch type {
        case .tag:
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
        case .favorite:
            storiesResult.removeAll()
            if(mainSearchBar.text == "") {
                storiesResult = stories
            } else {
                for story in stories {
                    if story.title.contains(mainSearchBar.text!) {
                        storiesResult.append(story)
                    }
                }
            }
        }
        self.mainTableView.reloadData()
    }
}
