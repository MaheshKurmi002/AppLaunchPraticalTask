//
//  LaunchInfoTVCell.swift
//  Task
//
//  Created by IPS-172 on 20/01/23.
//

import UIKit

class LaunchInfoTVCell: UITableViewCell {

    @IBOutlet weak var patchImg: UIImageView!
    @IBOutlet weak var missionVlbl: UILabel!
    @IBOutlet weak var daysVlbl: UILabel!
    @IBOutlet weak var rocketVlbl: UILabel!
    @IBOutlet weak var dateVlbl: UILabel!
    @IBOutlet weak var daysHlbl: UILabel!
    @IBOutlet weak var isDaysBeforelbl: UILabel!
    @IBOutlet weak var islaunchImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
