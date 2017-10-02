//
//  HomeViewController.swift
//  MySSConnect
//
//  Created by Atsuo Yonehara on 2017/10/02.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit
import SafariServices

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var mainTableView: UITableView!
    
    var list = ["ssまとめ","エレファント速報"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.mainTableView.register(UINib(nibName: "MainCell", bundle: nil), forCellReuseIdentifier: "MainCell")
        self.mainTableView.estimatedRowHeight = 90
        self.mainTableView.rowHeight = UITableViewAutomaticDimension
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showWebView(targetURL: String) {
        let url = URL(string: targetURL)!
        let webView = SFSafariViewController(url: url)
        present(webView, animated: true, completion: nil)
    }
}


extension HomeViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainTableViewCell
        cell.selectionStyle = .none
        cell.titleLabel?.text = "あかり「ゆるゆり最高」"
        cell.blogPickerView.dataSource = self//これと
        cell.blogPickerView.delegate = self//これ
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MainTableViewCell
        let selectedIndex = cell.blogPickerView.selectedRow(inComponent: 0)
        print(cell.titleLabel.text!)
        print(list[selectedIndex])
        showWebView(targetURL: "https://www.google.co.jp/")
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
        label.font = UIFont(name: list[row],size:5)
        return label
    }
}
