//
//  AddPostViewController.swift
//  RealmRelationship
//
//  Created by Kyaw Kyaw Khing on 9/23/19.
//  Copyright © 2019 Kyaw Kyaw Khing. All rights reserved.
//

import UIKit
import RealmSwift

class AddPostViewController: UIViewController {
    
    lazy var realm:Realm = {
        return try! Realm()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let category1 = Category()
        category1.id = 1
        category1.name = "C \(category1.id)"
        
        let category2 = Category()
        category2.id = 2
        category2.name = "C \(category2.id)"
        
        
        let reader1 = Reader()
        reader1.id = 1
        reader1.name = "R \(reader1.id)"
        
        let reader2 = Reader()
        reader2.id = 2
        reader2.name = "R \(reader2.id)"
        
        let reader3 = Reader()
        reader3.id = 3
        reader3.name = "R \(reader3.id)"
        
        let post1 = Post()
        post1.id = 1
        post1.title = "testing \(post1.id)"
        post1.desc = "description 1"
        post1.category = category1 //add category
        post1.readers.append(reader1) //add reader into readerlist
        post1.readers.append(reader2) //add reader into readerlist
        post1.readers.append(reader3) //add reader into readerlist
        
        
        let post2 = Post()
        post2.id = 2
        post2.title = "testing \(post2.id)"
        post2.desc = "description 1"
        post2.category = category2 //add category
        post2.readers.append(reader1) //add reader into readerlist
        post2.readers.append(reader2) //add reader into readerlist
        
        
        
        try! realm.write {
            let posts = realm.objects(Post.self)
            realm.delete(posts)
            
            let categories = realm.objects(Category.self)
            realm.delete(categories)
            
            let readers = realm.objects(Reader.self)
            realm.delete(readers)
            
            realm.add(post1)
            realm.add(post2)
        }
    }
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //
    //    }
    //
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
