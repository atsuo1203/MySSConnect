//
//  HomeViewController.swift
//  MySSConnect
//
//  Created by Atsuo Yonehara on 2017/10/02.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit
import SafariServices
import SwiftyJSON

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var mainTableView: UITableView!
    var stories = [Story]()
    let list = ["エレファント速報","b","c"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.mainTableView.register(UINib(nibName: "MainCell", bundle: nil), forCellReuseIdentifier: "MainCell")
        self.mainTableView.estimatedRowHeight = 90
        self.mainTableView.rowHeight = UITableViewAutomaticDimension
        getRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getRequest(){
        self.stories.removeAll()
        self.mainTableView.reloadData()
        
        API.getRequest().responseJSON { (response) in
//            print(response.response?.allHeaderFields)
            guard let object = response.result.value else {
                return
            }
            let json = JSON(object)
            json.forEach { (_, json) in
                let story = Story(json: json)
                self.stories.append(story)
            }
            print(self.stories[0].articles[0].blog.id)
            self.mainTableView.reloadData()
        }
    }
    
    func showWebView(targetURL: String) {
        let url = URL(string: targetURL)!
        let webView = SFSafariViewController(url: url)
        present(webView, animated: true, completion: nil)
    }

}


extension HomeViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainTableViewCell
        cell.selectionStyle = .none
        cell.titleLabel?.text = stories[indexPath.row].title
        cell.blogPickerView.dataSource = self
        cell.blogPickerView.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //押されたcellを取得
        let cell = tableView.cellForRow(at: indexPath) as! MainTableViewCell
        //何番目が押されたかを取得
        guard let row = self.mainTableView.indexPath(for: cell)?.row else {
            return
        }
        //押されたcellのpickerViewの選択されていた番号を取得
        let selectedIndex = cell.blogPickerView.selectedRow(inComponent: 0)
        
        print(row.description + "番目が押されて" + list[selectedIndex] + "が選択された")
        print(stories[row].tag_list)
//        showWebView(targetURL: (stories[row].articles?[0].url?.description)!)
    }
}

extension HomeViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    
    //列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //表示する数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    //表示する内容
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = UILabel()
        label.textAlignment = .center
        label.text = list[row]
        label.font = UIFont(name: "b",size:5)
        return label
    }
}
