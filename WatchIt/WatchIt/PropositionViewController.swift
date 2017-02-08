//
//  PropositionViewController.swift
//  WatchIt
//
//  Created by Paweł W. on 07/02/17.
//  Copyright © 2017 Bart. All rights reserved.
//

import UIKit

class PropositionViewController: UIViewController {

    var buttonID = 30
    
    @IBOutlet var timeButtons: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func timeButtonClicked(_ sender: UIButton) {
        buttonID = sender.tag
        for button in timeButtons {
            if button != sender {
                button.isSelected = false
                button.backgroundColor = .white
            } else {
                button.isSelected = true
                button.backgroundColor = .blue
            }
        }
    }

    @IBAction func givePropositionClicked(_ sender: AnyObject) {
        
    }
    

}
