# PopupTableView
Checkbox and Radio selection option in tableview popup

This tableview popup has option to select multiple(Checkbox) cell at a time OR Single selection(RADIO)

1. For multiple selection(Checkbox) use Below method

	func didReceiveActionOnCell(cell: CustomCell) {
        cell.radioImageView.image = UIImage(named: (cell.country?.isSelected)! ? "unselectedCheckbox" : "selectedCheckbox" )
        cell.country?.isSelected = (cell.country?.isSelected)! ? false : true
	}
    

2. For single selection(RADIO Button) uncomment this method in “CustomPopUp” class

	func didReceiveActionOnCell(cell: CustomCell) {
     
     	if tempCell != nil {
     		tempCell.radioImageView.image = UIImage(named: "inActive")
     	}
     	tempCell = cell
     	tempCell.radioImageView.image = UIImage(named: "active")
     
 	}
