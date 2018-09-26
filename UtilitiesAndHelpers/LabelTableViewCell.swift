//
//  LabelTableViewCell.swift
//  UtilitiesAndHelpers
//
//  Created by HTS on 9/7/18.
//  Copyright © 2018 HTS. All rights reserved.
//

import UIKit

class LabelTableViewCell: UITableViewCell,Reusable {

    @IBOutlet var lbl_title: UILabel!
    
    // Here we provide a nib for this cell class
    // (instead of relying of the protocol's default implementation)
    static var nib: UINib?
    {
        return UINib(nibName: String(describing:LabelTableViewCell.self), bundle: nil)
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
}
