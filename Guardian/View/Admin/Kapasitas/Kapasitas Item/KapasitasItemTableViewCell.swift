//
//  KapasitasItemTableViewCell.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 16/01/21.
//

import UIKit

class KapasitasItemTableViewCell: UITableViewCell {

    @IBOutlet weak var tongImg: UIImageView!
    @IBOutlet weak var namaTong: UILabel!
    @IBOutlet weak var kapasitasTong: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
