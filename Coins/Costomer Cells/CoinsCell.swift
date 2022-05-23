//
//  CoinsCell.swift
//  Coins
//
//  Created by Sakaoduean Thichaem on 21/5/2565 BE.
//

import Foundation
import UIKit

class CoinsCell: UICollectionViewCell {
    @IBOutlet weak var cryptoIconImage: UIImageView!
    @IBOutlet weak var cryptoNameLabel: UILabel!
    @IBOutlet weak var cryptoSymbolLabel: UILabel!
    @IBOutlet weak var cryptoPriceLabel: UILabel!
    @IBOutlet weak var cryptoChangeLabel: UILabel!
    
    @IBOutlet weak var cryptoCellWidthCon: NSLayoutConstraint!
    
    @IBOutlet weak var giftBoxImage: UIImageView!
    @IBOutlet weak var inviteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
