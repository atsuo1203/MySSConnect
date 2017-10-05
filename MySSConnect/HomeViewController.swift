//
//  HomeViewController.swift
//  MySSConnect
//
//  Created by Atsuo Yonehara on 2017/10/02.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var mainTableView: UITableView!
    var stories = [Story]()
    let list = ["エレファント速報","b","c"]
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.mainTableView.register(UINib(nibName: "MainCell", bundle: nil), forCellReuseIdentifier: "MainCell")
        self.mainTableView.register(UINib(nibName: "AddCell", bundle: nil), forCellReuseIdentifier: "AddCell")
        self.mainTableView.estimatedRowHeight = 90
        self.mainTableView.rowHeight = UITableViewAutomaticDimension
        getStories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getStories(){
        self.mainTableView.reloadData()
        
        API.getStories(tag: "", q: "", page: page.description).responseJSON { (response) in
//            print(response.response?.allHeaderFields)
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


extension HomeViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < stories.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainTableViewCell
            cell.selectionStyle = .none
            cell.titleLabel?.text = stories[indexPath.row].title
            cell.blogPickerView.dataSource = self
            cell.blogPickerView.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCell", for: indexPath) as! AddTableViewCell
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < stories.count {
            //押されたcellを取得
            let cell = tableView.cellForRow(at: indexPath) as! MainTableViewCell
            //何番目が押されたかを取得
            guard let row = self.mainTableView.indexPath(for: cell)?.row else {
                return
            }
            //押されたcellのpickerViewの選択されていた番号を取得
            let selectedIndex = cell.blogPickerView.selectedRow(inComponent: 0)
            
            print(row.description + "番目が押されて" + list[selectedIndex] + "が選択された")
            API.showWebView(viewController: self, targetURL: stories[row].articles[0].url)
        } else {
            self.page += 1
            getStories()
        }
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
