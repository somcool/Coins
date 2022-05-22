//
//  CoinCell.swift
//  Coins
//
//  Created by Sakaoduean Thichaem on 16/5/2565 BE.
//

import Foundation
import UIKit
import WebKit

class CoinCell: UITableViewCell {
    
    @IBOutlet weak var cryptoImageView: UIImageView!
    @IBOutlet weak var fullNameCryptoLabel: UILabel!
    @IBOutlet weak var nameCryptoLabel: UILabel!
    @IBOutlet weak var priceCryptoLabel: UILabel!
    
    @IBOutlet weak var priceUpDownCryptoLabel: UILabel!
}
