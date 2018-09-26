//
//  ViewController.swift
//  UtilitiesAndHelpers
//
//  Created by HTS on 4/11/18.
//  Copyright © 2018 HTS. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet var tbl_sample: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tbl_sample.registerReusableCell(LabelTableViewCell.self)
        tbl_sample.registerReusableCell(CodeLabelTableViewCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
    }
}

extension ViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.row % 2 == 0
        {
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as LabelTableViewCell
            cell.lbl_title.text = "the row is \(indexPath.row)"
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as CodeLabelTableViewCell
            return cell
        }
    }
}
extension ViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 40.0
    }
}


