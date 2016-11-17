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
    var watchables = NSArray()
    var latestTitle: Observable<String?> {
        return searchBar.rx.text
                .throttle(0.5, scheduler: MainScheduler.instance)
                .distinctUntilChanged()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findMovies("The Matrix")
        setupRx()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func findMovies(_ title: String) {
        _ = provider.request(.Movie(title: title)) { result in
            if result != nil {
            switch result {
            case let .success(response):
                do {
                    if let json = try response.mapJSON() as? NSArray {
                        // Presumably, you'd parse the JSON into a model object. This is just a demo, so we'll keep it as-is.
                        self.watchables = json
                        print("watchablesJSON: \(self.watchables)")
                    } else {
                        print("didn't find any")
                    }
                } catch {
                    print("unable to find any")
                }
                self.tableView.reloadData()
            case let .failure(error):
                guard let error = error as? CustomStringConvertible else {
                    break
                }
                print("error \(error.description)")
            }
            }
            else {
                print("NO RESULTS")
            }
        }
    }
    
    func setupRx() {
        provider = MoyaProvider<OMDB>()
        tableView.rx.itemSelected.subscribe(onNext:{ indexPath in
            if self.searchBar.isFirstResponder == true {
                self.view.endEditing(true)
            }
            
        }).addDisposableTo(disposeBag)
        
    }
}

