//
//  MakeViewController.swift
//  RealmToDo
//
//  Created by 高橋達朗 on 2019/07/30.
//  Copyright © 2019 高橋達朗. All rights reserved.
//

import UIKit
import RealmSwift

class MakeViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    var todo: Todo? = nil
    
    @IBOutlet weak var button: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if todo !== nil {
//            追加
            button.setTitle("追加", for: .normal)
        } else {
//            編集
            button.setTitle("更新", for: .normal)
            textField.text = todo?.title
        }
    }
    
    func createNewTodo(_ text: String) {
        //        新規タスクを追加
        // Realmに接続
        let realm = try! Realm()
        
        // データを登録する
        let todo = Todo()
        // 最大のIDを取得
        let id = getMaxId()
        
        todo.id = id
        todo.title = text
        todo.date = Date()
        
        // 作成したTODOを登録する
        try! realm.write {
            realm.add(todo)
        }
    }
    
    fileprivate func updateTodo(_ text: String) {
        //            更新
        let realm = try! Realm()
        
        try! realm.write {
            todo?.title = text
        }
    }
    
    @IBAction func didClickButton(_ sender: UIButton) {
        
//       nil文字かチェック
        guard let text = textField.text else
        {
//            textField.textがnilの場合
            
//            ボタンがクリックされた時の処理を中断
            return
        }
        
        if text.isEmpty {
//            textField.textが空文字の場合
//            ボタンがクリックされた時の処理を中断
            return
        }
        
        if todo == nil {
//        新規タスク
        createNewTodo(text)
        
        } else {
            updateTodo(text)
        }
        
//        戻る前画面に
//        履歴から一つ前に戻る
    navigationController?.popViewController(animated: true)
    }
//最大のIDを取得するメゾット
    func getMaxId() -> Int {
//        Realmに接続
        let realm = try! Realm()
        
//        Todoのシートから最大のIDを取得する
        let id = realm.objects(Todo.self).max(ofProperty: "id") as Int?
        
        if id == nil {
//            最大IDがnil場合、１返す
            return 1
        } else {
//            最大IDが存在、最大ID + 1返す
            return id! + 1
        }
    }

}
