//
//  CustomPopUp.swift
//  TableViewPopUp
//
//  Created by UTTAM on 21/12/17.
//  Copyright © 2017 UTTAM. All rights reserved.
//

import UIKit


protocol DoneButtonDelegate : class {
    func didReceiveActionOnDoneButton()
}

class CustomePopUp : UIView {
    
    var array:[Country]? = []
    private let cellId = "CellId"
    fileprivate var tempCell:CustomCell!
    weak var doneButtonDelegate: DoneButtonDelegate?
    
    init(frame: CGRect,list: [Country]?) {
        super.init(frame: frame)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture(_:)))
        self.addGestureRecognizer(tapGesture)
        self.array = list
        setup()
    }
    
    var containerView: UIButton = {
        let view = UIButton()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10.0
        return view
    }()
    
    var titleLabel : UIButton = {
        let label = UIButton()
        label.setTitle("Select List", for: .normal)
        label.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        label.isHighlighted = false
        label.contentHorizontalAlignment = .left
        label.setTitleColor(UIColor.darkGray, for: .normal)
        return label
    }()
    
    var topSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    var bottomSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    var tableView:UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        return table
    }()
    
    var doneButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitle("DONE", for: .normal)
        return button
    }()
    
    let bgView = UIView()
    
    func setup() {
        
        bgView.backgroundColor = UIColor(white: 0, alpha: 0.8)
        addSubview(bgView)
        addSubview(containerView)
        
        containerView.addSubview(tableView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(topSeperatorView)
        containerView.addSubview(bottomSeperatorView)
        
        doneButton.addTarget(self , action: #selector(doneButtonAction), for: .touchUpInside)
        containerView.addSubview(doneButton)
        
        tableView.register(CustomCell.self, forCellReuseIdentifier: cellId)
        tableView.dataSource = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.frame = self.frame
        containerView.frame = CGRect(x: frame.size.width*0.20, y: frame.size.height*0.25, width: frame.size.width*0.6, height: frame.size.height*0.5)
        
        titleLabel.frame = CGRect(x: frame.size.width*0.02, y: 0, width: containerView.frame.size.width - frame.size.width*0.04, height: 50)
        topSeperatorView.frame = CGRect(x: frame.size.width*0.02, y: 50, width: containerView.frame.size.width - frame.size.width*0.04, height: 1)
        
        bottomSeperatorView.frame = CGRect(x: frame.size.width*0.02, y: containerView.frame.size.height - 51, width: containerView.frame.size.width - frame.size.width*0.04, height: 1)
        
        doneButton.frame = CGRect(x: 0 , y: containerView.frame.size.height - 50 , width:  containerView.frame.size.width, height: 50)
        doneButton.layer.cornerRadius = 25
        
        tableView.frame = CGRect(x: frame.size.width*0.02, y: 52 , width:  containerView.frame.size.width - frame.size.width*0.04, height: containerView.frame.size.height - 105)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapGesture(_ sender: UIGestureRecognizer) {
        removeView()
    }
    // Removing popup view from super view with animation
    func removeView() {
        self.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {() -> Void in
            self.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        }, completion: {(finished: Bool) -> Void in
            self.removeFromSuperview()
        })
    }
    
    @objc func doneButtonAction(_ sender: UIButton) {
        removeView()
        if doneButtonDelegate != nil {
            doneButtonDelegate?.didReceiveActionOnDoneButton()
        }
    }
}

extension CustomePopUp : UITableViewDataSource , CellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! CustomCell
        cell.delegate = self
        cell.country = array?[indexPath.row] ?? nil
        return cell
    }
    
    // Checkbox Button selection
    func didReceiveActionOnCell(cell: CustomCell) {
        cell.radioImageView.image = UIImage(named: (cell.country?.isSelected)! ? "unselectedCheckbox" : "selectedCheckbox" )
        cell.country?.isSelected = (cell.country?.isSelected)! ? false : true
    }
    
    
    // Radio Button selection
    /*
     func didReceiveActionOnCell(cell: CustomCell) {
     
     if tempCell != nil {
     tempCell.radioImageView.image = UIImage(named: "inActive")
     }
     tempCell = cell
     tempCell.radioImageView.image = UIImage(named: "active")
     
     }
     */
}
