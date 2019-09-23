//
//  ViewController.swift
//  RealmRelationship
//
//  Created by Kyaw Kyaw Khing on 9/22/19.
//  Copyright © 2019 Kyaw Kyaw Khing. All rights reserved.
//

import UIKit
import RealmSwift
//import Realm
//import RxRealm

class ViewController: UIViewController {

    @IBOutlet weak var tvPosts: UITableView!
    lazy var realm:Realm = {
        return try! Realm()
    }()
    
    var postList:Results<Post>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tvPosts.delegate = self
        self.tvPosts.dataSource = self
        self.tvPosts.estimatedRowHeight = 100
        self.tvPosts.rowHeight = UITableView.automaticDimension
        
        let readers = realm.objects(Reader.self)
        let categories = realm.objects(Category.self)
        self.navigationItem.title = "Readers : \(readers.count) Categories : \(categories.count)"
        self.postList = realm.objects(Post.self)
        self.tvPosts.reloadData()
    }

    @IBAction func onClickCancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsTableViewCell", for: indexPath) as! PostsTableViewCell
        let postItem = postList[indexPath.row]
        var readers = ""
        for reader in postItem.readers{
            readers += "\(reader.name)"
            if postItem.readers.index(of: reader) != postItem.readers.count-1{
                readers += " , "
            }
        }
        let desp = "\(postItem.title) \n Category : \(postItem.category?.name ?? "") \n Readers: (\(readers))"
        cell.lblDetail.text = desp
        return cell
    }
    
}

class Post:Object{
//    override static func primaryKey() -> String? {
//        return "id"
//    }
    
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var desc = ""
    @objc dynamic var category:Category? = nil
    var readers = List<Reader>()
}

class Category:Object {
    @objc dynamic var id:Int = 0
    @objc dynamic var name:String = ""
}

class Reader:Object{
    @objc dynamic var id:Int = 0
    @objc dynamic var name:String = ""
    var posts = LinkingObjects(fromType: Post.self, property: "readers")
    
}
