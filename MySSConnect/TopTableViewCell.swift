//
//  TopTableViewCell.swift
//  GetPostTest
//
//  Created by Atsuo Yonehara on 2017/09/25.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit

class TopTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
