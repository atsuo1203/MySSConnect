//
//  AddTableViewCell.swift
//  MySSConnect
//
//  Created by Atsuo Yonehara on 2017/10/05.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit

class AddTableViewCell: UITableViewCell {
    @IBOutlet weak var addLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addLabel.text = "もっと見る"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
