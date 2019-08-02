//
//  ViewController.swift
//  RealmToDo
//
//  Created by 高橋達朗 on 2019/07/30.
//  Copyright © 2019 高橋達朗. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var todos:[Todo] = []
    
    fileprivate func reloadTableView() {
        //        realmに接続
        let realm = try! Realm()
        //        Todoの一覧を取得
        todos = realm.objects(Todo.self).reversed()
        
//        テーブルを更新
        tableView.reloadData()
    }
//    画面が最初の一回だけ実行
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        reloadTableView()
    }
//    画面が表示されるたびに実行
    override func viewWillAppear(_ animated: Bool) {
        reloadTableView()
    }

    @IBAction func didClickAddBtn(_ sender: UIButton) {
        
        performSegue(withIdentifier: "toNext", sender: nil)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.title
        
//        cellに矢印をつける
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
//    セルがクリックくされた時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        クリックされたTODOを取得する
        let todo = todos[indexPath.row]
        
        performSegue(withIdentifier: "toNext", sender: todo)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toNext" {
//            次の画面のやつを取得
            let inputVC = segue.destination as! MakeViewController
//            次の画面に選択されたTODOを設定
            inputVC.todo = sender as? Todo
        }
    }
    
}
