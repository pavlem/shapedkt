//
//  WeeatherListTVC.swift
//  forecast
//
//  Created by Pavle Mijatovic on 8/4/19.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import UIKit

class WeeatherListTVC: UITableViewController {
    
    let source = ["1", "2", "3", "1", "2", "3", "1", "2", "3", "1", "2", "3", "1", "2", "3"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeeatherListCell_ID", for: indexPath)

        cell.textLabel?.text = source[indexPath.row]
        // Configure the cell...

        return cell
    }
    
    
    var weatherVC: WeatherVC? {
        if let wVC = self.parent as? WeatherVC {
            return wVC
        }
        return nil
    }
}

extension WeeatherListTVC {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        
//        guard scrollView.contentOffset.y > 0 else { return }
        
        guard let cst = weatherVC?.testCst else { return }
//        guard cst.constant > 0 else { return }

        
        
        if 100 - scrollView.contentOffset.y < 0 {
            return
        }
        cst.constant = 100 - scrollView.contentOffset.y
        
    }
}
