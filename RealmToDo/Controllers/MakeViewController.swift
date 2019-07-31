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
    
//    前の画面から渡されたTODOを受け取る変数
    var todo: Todo? = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    fileprivate func createNewTodo(_ text: String) {
        //        Realmに接続
        let realm = try! Realm()
        //        データ登録
        let todo = Todo()
        //        最大ID取得
        let id = getMaxId()
        
        todo.id = id
        todo.title = text
        todo.date = Date()
        
        
        //        作成したTODOを登録する
        try! realm.write {
            realm.add(todo)
        }
    }
    
    @IBAction func didClickButton(_ sender: UIButton) {
        
//       nil文字かチェック
        guard let text = textField.text else {
//            textField.textがnilの場合
            
//            ボタンがクリックされた時の処理を中断
            return
        }
        
        if text.isEmpty {
//            textField.textが空文字の場合
//            ボタンがクリックされた時の処理を中断
            return
        }
        
//        新規タスクを追加
        createNewTodo(text)
        
        
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
