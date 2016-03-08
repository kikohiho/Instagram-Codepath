//
//  postCell.swift
//  Instagram Codepath
//
//  Created by Ricardo Vila on 3/6/16.
//  Copyright © 2016 Ricardo Vila. All rights reserved.
//

import UIKit
import Parse


class postCell: UITableViewCell {
    
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
  /**  var cellData: PFObject! {
        didSet {
            self.captionLabel.text = cellData["caption"] as? String
            self.photoView.file = cellData["media"] as? PFFile
            self.photoView.loadInBackground()
                        
        }
    }
  **/
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
