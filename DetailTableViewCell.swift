//
//  DetailTableViewCell.swift
//  Marmeto
//
//  Created by thincnext on 27/09/18.
//  Copyright © 2018 thincnext. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
