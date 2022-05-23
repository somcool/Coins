//
//  TopCoinCell.swift
//  Coins
//
//  Created by Sakaoduean Thichaem on 21/5/2565 BE.
//

import Foundation
import UIKit

class TopCoinCell: UICollectionViewCell {
    @IBOutlet weak var cryptoImageView: UIImageView!
    @IBOutlet weak var cryptoNameLabel: UILabel!
    @IBOutlet weak var cryptoSymbolLabel: UILabel!
    @IBOutlet weak var cryptoChangeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
