//
//  ViewController.swift
//  WatchIt
//
//  Created by Paweł W. on 14/10/16.
//  Copyright © 2016 Bart. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Moya

class Repository {
    
}

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchResults = searchBar.rx.text
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .do(onNext: { (query) in
                print(query)
                }, onError: { (error) in
                    print("error : \(error)")
                }, onCompleted: nil, onSubscribe: nil, onDispose: nil)
            .observeOn(MainScheduler.instance)
        // Do any additional setup after loading the view, typically from a nib.
        searchResults.subscribe { (query) in
            print(query)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

