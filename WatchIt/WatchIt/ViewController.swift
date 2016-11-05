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
import RxOptional

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    let disposeBag = DisposeBag()
    var provider: MoyaProvider<OMDB>!
    var latestTitle: Observable<String?> {
        return searchBar.rx.text.throttle(0.5, scheduler: MainScheduler.instance).distinctUntilChanged()
//                .throttle(0.5, scheduler: MainScheduler.instance)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupRx() {
        
    }
}

