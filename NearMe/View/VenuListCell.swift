//
//  VenuListCell.swift
//  NearMe
//
//  Created by Eren Besel on 2019/08/22.
//  Copyright © 2019 Eren Besel. All rights reserved.
//

import UIKit

class VenuListCell: UITableViewCell {
    
    @IBOutlet private weak var iconImageView: AsyncImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var bottomLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with cellModel: VenuListCellModel) {
        iconImageView.imageUrl = cellModel.iconUrl
        titleLabel.text = cellModel.title
        subtitleLabel.text = cellModel.address
        bottomLabel.text = cellModel.distanceText
    }
    
}
