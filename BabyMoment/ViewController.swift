//
//  ViewController.swift
//  BabyMoment
//
//  Created by Xueliang Zhu on 8/24/16.
//  Copyright © 2016 kotlinchina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 314
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
}

extension ViewController: UITableViewDataSource {
  
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MomentCell
        return cell
    }
}

