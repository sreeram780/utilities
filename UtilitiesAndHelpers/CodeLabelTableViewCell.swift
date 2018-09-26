//
//  CodeLabelTableViewCell.swift
//  UtilitiesAndHelpers
//
//  Created by HTS on 9/7/18.
//  Copyright © 2018 HTS. All rights reserved.
//

import UIKit

class CodeLabelTableViewCell: UITableViewCell,Reusable {
    
    let messageLabel = UILabel()
    let bubbleBackgroundView = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        bubbleBackgroundView.backgroundColor = .yellow
        bubbleBackgroundView.layer.cornerRadius = 5
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bubbleBackgroundView)
        
        addSubview(messageLabel)
        //        messageLabel.backgroundColor = .green
        messageLabel.text = "We want to provide a longer string that is actually going to wrap onto the next line and maybe even a third line."
        messageLabel.numberOfLines = 0
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // lets set up some constraints for our label
        let constraints = [messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
                           messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
                           messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
                           messageLabel.widthAnchor.constraint(equalToConstant: 250),
                           
                           bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
                           bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16),
                           bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
                           bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16),
                           ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
