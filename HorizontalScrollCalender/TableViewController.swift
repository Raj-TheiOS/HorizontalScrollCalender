//
//  TableViewController.swift
//  HorizontalScrollCalender
//
//  Created by HT-Admin on 21/01/20.
//  Copyright © 2020 HT-Admin. All rights reserved.
//

import UIKit

class TableViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    
    @IBOutlet weak var tv: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tv.register(UINib(nibName: "TableCell", bundle: nil), forCellReuseIdentifier: "TableCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
    }

    @objc func methodOfReceivedNotification(notification: Notification)
    {
        print("Value of notification : ", notification.object ?? "")
        
        let userInfo = notification.object as! NSDictionary
        print("Value of notification : ",userInfo["date"]!)
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
        cell.label.text = "\(indexPath.row)"
        return cell

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

}
