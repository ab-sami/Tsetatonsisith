//
//  DeliverTableViewCell.swift
//  Tsetatonsisith
//
//  Created by Abdul Sami on 21/09/2018.
//  Copyright © 2018 Abdul Sami. All rights reserved.
//

import UIKit

class DeliverTableViewCell: UITableViewCell {
    
    let deliveryDescriptionNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        lbl.textAlignment = .left
        lbl.numberOfLines = 2
        //lbl.lineBreakMode = .byWordWrapping
        lbl.clipsToBounds = true
        return lbl
    }()
    
    let deliveryImage : CustomImageView = {
        let imgView = CustomImageView(image: #imageLiteral(resourceName: "Snow"))
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(deliveryImage)
        addSubview(deliveryDescriptionNameLabel)
        
        deliveryImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: kRowHeight, height: kRowHeight, enableInsets: false)
        deliveryDescriptionNameLabel.anchor(top: topAnchor, left: deliveryImage.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0, enableInsets: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
