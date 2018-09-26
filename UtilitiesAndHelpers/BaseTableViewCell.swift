//
//  BaseTableViewCell.swift
//  UtilitiesAndHelpers
//
//  Created by HTS on 9/7/18.
//  Copyright © 2018 HTS. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell,Reusable {

    // Here we provide a nib for this cell class
    // (instead of relying of the protocol's default implementation)
//    var nib: UINib?
//    {
//        return UINib(nibName: String(describing:BaseTableViewCell.self), bundle: nil)
//    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }

}
