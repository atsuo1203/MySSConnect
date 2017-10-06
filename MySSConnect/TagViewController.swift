//
//  TagViewController.swift
//  MySSConnect
//
//  Created by Atsuo Yonehara on 2017/10/02.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit
import SwiftyJSON

class TagViewController: UIViewController {
    @IBOutlet weak var tagSearchBar: UISearchBar!
    @IBOutlet weak var mainTableView: UITableView!
    var tags = [Tag]()
    var searchResult = [Tag]()

    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.mainTableView.register(UINib(nibName: "TagCell", bundle: nil), forCellReuseIdentifier: "TagCell")
        //searchBar
        self.tagSearchBar.delegate = self
        self.tagSearchBar.enablesReturnKeyAutomatically = false
        //tag取得
        getTags()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
            self.searchResult = self.tags
            self.mainTableView.reloadData()
        }
    }
}

extension TagViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell", for: indexPath) as! TagTableViewCell
        cell.selectionStyle = .none
        cell.nameLabel.text = searchResult[indexPath.row].name
        cell.countLabel.text = "(" + searchResult[indexPath.row].taggings_count.description + ")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Result", bundle: nil)
        let nextVC = storyboard.instantiateInitialViewController() as! ResultViewController
        nextVC.tag = searchResult[indexPath.row].name
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension TagViewController: UISearchBarDelegate {
    //searchBarで検索した時の処理
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        tagSearchBar.endEditing(true)
        searchResult.removeAll()
        
        if(tagSearchBar.text == "") {
            searchResult = tags
        } else {
            for tag in tags {
                if tag.name.contains(tagSearchBar.text!) {
                    searchResult.append(tag)
                }
            }
        }
        self.mainTableView.reloadData()
    }
}
