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
    var lastPage = 1
    //pageが最初か最後か
    var isFirstPage = false
    var isLastPage = false
    //storyとarticle
    var stories = [Story]()
    var articles = [Article]()
    
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "page遷移", style: .plain, target: self, action: #selector(self.alert))
        getStories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.articles.removeAll()
        self.mainTableView.reloadData()
    }
    
    func getStories(){
        self.stories.removeAll()
        self.articles.removeAll()
        API.getStories(tag: tag, q: q, page: page.description).responseJSON { (response) in
            self.setPage(data: response.response)
            guard let object = response.result.value else {
                return
            }
            let json = JSON(object)
            json.forEach { (_, json) in
                let story = Story(json: json)
                self.stories.append(story)
            }
            self.mainTableView.reloadData()
            self.mainTableView.setContentOffset(CGPoint(x: 0,y: -self.mainTableView.contentInset.top), animated: false)
            self.mainTableView.reloadData()
        }
    }
    
    func alert(){
        let alert = UIAlertController(title: "page遷移", message: "", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default) { (action) in
            let textField = alert.textFields?[0]
            let pageNumber = Int(textField!.text!)
            if pageNumber != nil {
                if pageNumber! < self.lastPage {
                    self.page = pageNumber!
                    self.getStories()
                } else {
                    let alert2 = UIAlertController(title: "警告", message: "pageが存在しません", preferredStyle: .alert)
                    let defaultAction2 = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert2.addAction(defaultAction2)
                    self.present(alert2, animated: true, completion: nil)
                }
            } else {
                    let alert2 = UIAlertController(title: "警告", message: "数字を入力してください", preferredStyle: .alert)
                    let defaultAction2 = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert2.addAction(defaultAction2)
                    self.present(alert2, animated: true, completion: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
        }
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        alert.addTextField { (textField) in }
        
        present(alert, animated: true, completion: nil)
    }
    
    //headerから取ってきた要素で、現在のpageと全pageを判定する
    func setPage(data: HTTPURLResponse?){
        let header = data?.allHeaderFields
        if header != nil {
            let parameter = header!.description.components(separatedBy: ",")
            let page = parameter[2].components(separatedBy: " ").last!
            let lastPage = parameter[9].components(separatedBy: " ").last!
            self.page = Int(page)!
            self.lastPage = Int(lastPage)!
            self.isFirstPage = self.page <= 1
            self.isLastPage = self.page == self.lastPage
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
            if isFirstPage {
                cell.addLabel.textColor = UIColor.lightGray
                cell.addLabel.text = "前のページへ"
            } else {
                cell.addLabel.textColor = UIColor.blue
                cell.addLabel.text = "前のページへ(" + (self.page - 1).description + "/" + self.lastPage.description + ")"
            }
            cell.selectionStyle = .none
            return cell
        } else if (indexPath.row < stories.count + 1) && (indexPath.row > 0) {
            let story = stories[indexPath.row - 1]
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainTableViewCell
            cell.selectionStyle = .none
            cell.titleLabel?.text = story.title
            cell.dateLabel.text = story.first_posted_at.components(separatedBy: "T").first!
            
            //realmに入っているblogIDで判定
            var blogName = story.articles[0].blog.title
            var resultArticle = story.articles[0]
            story.articles.forEach({ (article) in
                if article.blog.id == RealmBlog.getID(name: "realm") {
                    blogName = article.blog.title
                    resultArticle = article
                }
            })
            cell.blogLabel.text = blogName
            self.articles.append(resultArticle)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCell", for: indexPath) as! AddTableViewCell
            cell.selectionStyle = .none
            if isLastPage {
                cell.addLabel.textColor = UIColor.lightGray
                cell.addLabel.text = "次のページへ"
            } else {
                cell.addLabel.textColor = UIColor.blue
                cell.addLabel.text = "次のページへ(" + (self.page + 1).description + "/" + self.lastPage.description + ")"
                
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if !isFirstPage {
                page -= 1
                getStories()
            }
        } else if (indexPath.row < stories.count + 1) && (indexPath.row > 0) {
            //押されたcellを取得
            let cell = tableView.cellForRow(at: indexPath) as! MainTableViewCell
            //何番目が押されたかを取得
            guard let row = self.mainTableView.indexPath(for: cell)?.row else {
                return
            }
            API.showWebView(viewController: self, targetURL: self.articles[row - 1].url)
        } else {
            if !isLastPage {
                page += 1
                getStories()
            }
        }
    }
}
