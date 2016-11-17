//
//  ViewController.swift
//  WatchItSwift2.3
//
//  Created by Paweł W. on 17/11/16.
//  Copyright © 2016 Bart. All rights reserved.
//

import UIKit
import Moya
import Moya_ModelMapper
import RxCocoa
import RxSwift
import RxOptional


class ViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

