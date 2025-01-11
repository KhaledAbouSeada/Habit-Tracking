//
//  HabitTableViewCell.swift
//  Habit Tracking App
//
//  Created by Khaled on 11/01/2025.
//

import UIKit

class HabitTableViewCell: UITableViewCell {

    @IBOutlet weak var habitNameLabel: UILabel!
    @IBOutlet weak var completionImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowOpacity = 0.3
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 4
        containerView.layer.masksToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
