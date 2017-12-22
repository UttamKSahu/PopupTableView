//
//  CustomCell.swift
//  TableViewPopUp
//
//  Created by UTTAM on 22/12/17.
//  Copyright © 2017 UTTAM. All rights reserved.
//

import UIKit


protocol CellDelegate : class {
    func didReceiveActionOnCell(cell: CustomCell)
}

class CustomCell : UITableViewCell {
    var button: UIButton!
    var radioImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        //        imageView.image = UIImage(named: "inActive") // This is for radio button
        imageView.image = UIImage(named: "unselectedCheckbox") // This is for Checkbox
        return imageView
    }()
    weak var delegate: CellDelegate?
    
    var country: Country? = nil {
        didSet {
            if let country = country {
                textLabel?.text = country.name
                // Radio button
                //                radioImageView.image = UIImage(named: country.isSelected ? "active" : "inActive")
                radioImageView.image = UIImage(named: country.isSelected ? "selectedCheckbox" : "unselectedCheckbox")
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        button = UIButton()
        button.isSelected = false
        button.frame = self.frame
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        textLabel?.font = UIFont.systemFont(ofSize: 14)
        addSubview(button)
        addSubview(radioImageView)
    }
    
    @objc func buttonAction(_ sender: UIButton) {
        if delegate != nil {
            delegate?.didReceiveActionOnCell(cell: self)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        radioImageView.frame = CGRect(x: self.frame.size.width - self.frame.size.height/2, y: self.frame.size.height/2 - self.frame.size.height/4, width: self.frame.size.height/2, height: self.frame.size.height/2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
