//
//  SearchListCell.swift
//  CheckList
//
//  Created by Sumona Salma on 4/13/19.
//  Copyright © 2019 Sumona Salma. All rights reserved.
//

import UIKit

class SearchListCell: UITableViewCell {
    let titleLabel = CommonUIContainer.shared.commonLabelUI(text: "Title", color: UIColor.clear,textColor:UIColor.black)
    
    let bookmarkBTN = CommonUIContainer.shared.commonInputButton(withColor: UIColor.lightGray, title: "BookMark", width: 0, height: 0, target: "", alphaVal: 0.7, titleColor: UIColor.black)
    var info: PageData? {
        didSet {
            if let title = info?.title {
                titleLabel.text = title
            }
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        titleLabel.clipsToBounds = true
        titleLabel.preferredMaxLayoutWidth = (self.bounds.size.width) - 10
        
        
        self.addSubview(titleLabel)
        self.addSubview(bookmarkBTN)
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor,constant:10),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bookmarkBTN.rightAnchor.constraint(equalTo: rightAnchor, constant:-10),
            bookmarkBTN.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            bookmarkBTN.topAnchor.constraint(equalTo: topAnchor,constant:5),
            bookmarkBTN.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)

        ])

    }
}
