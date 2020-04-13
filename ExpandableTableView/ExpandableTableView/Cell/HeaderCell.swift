//
//  HeaderCell.swift
//  ExpandableTableView
//
//  Created by Rakesh Kumar on 13/04/20.
//  Copyright © 2020 RakeshPC. All rights reserved.
//

import UIKit
protocol HeaderViewDelegate {
    func cellHeader(idx: Int)
}


class HeaderCell: UITableViewCell {

    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var backView: UIView!

    var sectionIndex: Int?
      var delegate: HeaderViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tap(_ sender: UIButton) {
        if let index = sectionIndex {
            delegate?.cellHeader(idx: index)
        }
    }
}
