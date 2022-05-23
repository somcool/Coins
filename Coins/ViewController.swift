//
//  ViewController.swift
//  Coins
//
//  Created by Sakaoduean Thichaem on 16/5/2565 BE.
//

import UIKit
import AlamofireImage
import WebKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {

    @IBOutlet weak var TopRankCollection: UICollectionView!
    @IBOutlet weak var amountTopRankLabel: UILabel!
    @IBOutlet weak var coinsCollection: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var coinsCollectionHeightCon: NSLayoutConstraint!
    
    @IBOutlet weak var content: UIView!
    //-----
    @IBOutlet weak var coinDetailViewHighCon: NSLayoutConstraint!
    @IBOutlet var coinDetailView: UIView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var cryptoDetailIconImage: UIImageView!
    @IBOutlet weak var cryptoDetailNameLabel: UILabel!
    @IBOutlet weak var cryptoDetailSymbolLabel: UILabel!
    @IBOutlet weak var cryptoDetailPriceLabel: UILabel!
    @IBOutlet weak var cryptoDetailMarketCapLabel: UILabel!
    @IBOutlet weak var cryptoDetailLabel: UILabel!
    @IBOutlet weak var cryptoDetailWebsiteLabel: UIButton!
    
    var coins = [Coins]()
    let amountTopRank = 3
    var loaded = 20
    var countShowCoins = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getCoins(collectionView: self.TopRankCollection, parameters: ["limit" : self.amountTopRank])
        self.getCoins(collectionView: self.coinsCollection, parameters: ["limit" : self.loaded])

        self.amountTopRankLabel.text = "\(self.amountTopRank)"
        
        self.coinsCollection.register(UINib(nibName: "CoinsCell", bundle: nil), forCellWithReuseIdentifier: "CCell")
        self.coinsCollection.register(UINib(nibName: "InviteCell", bundle: nil), forCellWithReuseIdentifier: "GiftCell")
        
        self.coinsCollection.isScrollEnabled = false
        hideDetail()
        
    }
    
    // MARK: ScrollView
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.coinsCollection.isScrollEnabled = false
    }
    
    // MARK: Collection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.TopRankCollection {
            return self.coins.count > 0 ? self.amountTopRank : 0
        } else if collectionView == self.coinsCollection {
            return self.coins.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.coinsCollection {
            let cell : CoinsCell
            if indexPath.row == self.countShowCoins {
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GiftCell", for: indexPath) as! CoinsCell
                cell.cryptoCellWidthCon.constant = collectionView.bounds.width - 20 //width of cell
                self.countShowCoins = self.countShowCoins*2
                return cell
            } else {
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CCell", for: indexPath) as! CoinsCell
            }
            
            let coin = self.coins[indexPath.row]
            
            //-icon
            //cell.cryptoIconImage
            //let urlRequest = URLRequest(url: URL(string: "https://cdn.coinranking.com/bOabBYkcX/bitcoin_btc.svg")!)
            //cell.iconWebView.load(urlRequest)
            cell.cryptoNameLabel.text = coin.name
            cell.cryptoSymbolLabel.text = coin.symbol
            cell.cryptoPriceLabel.text = String(format: "%.5f", coin.price)
            var allow = ""
            if coin.change >= 0 {
                allow = "↑"
                cell.cryptoChangeLabel.textColor = .systemGreen
            } else {
                allow = "↓"
                cell.cryptoChangeLabel.textColor = .systemRed
            }
            cell.cryptoChangeLabel.text = allow + String(format: "%.2f", coin.change)
            
            cell.cryptoCellWidthCon.constant = collectionView.bounds.width - 20
            
            return cell
            
        } else { // Top 3 Rank
            let coin = self.coins[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TopCoinCell
            //-icon
            //cell.cryptoIconImage
            cell.cryptoNameLabel.text = coin.name
            cell.cryptoSymbolLabel.text = coin.symbol
            var allow = ""
            if coin.change >= 0 {
                allow = "↑"
                cell.cryptoChangeLabel.textColor = .systemGreen
            } else {
                allow = "↓"
                cell.cryptoChangeLabel.textColor = .systemRed
            }
            cell.cryptoChangeLabel.text = allow + String(format: "%.2f", coin.change)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.getCoinDetail(uuid: self.coins[indexPath.row].uuid)
    }
    
    func getCoins(collectionView: UICollectionView, parameters: [String : Any]?) { //limit offset
        ServerConnector.call("coins", parameters: nil, completionHandler: { (data) in
            self.coins = Coins.coinsFromJSONArray(data["coins"])

            let cellHeight = 80
            let pandding = 5
            let allCellHeight: Double = Double(cellHeight+pandding)
            self.coinsCollectionHeightCon.constant = CGFloat( Double(self.coins.count)*allCellHeight )
                
            if collectionView == self.coinsCollection {
                //self.countShowCoins = self.countShowCoins * 2
            }
            self.loaded = self.loaded + 20
            collectionView.reloadData()
        }, errorHandler: { (errorCode, errorDesc) in
        })
    }
    
    var link: String?
    func getCoinDetail(uuid: String) {
        
        ServerConnector.call("coin/\(uuid)", parameters: nil, completionHandler: { (data) in
            let coin = Coins(data: data["coin"])
            self.link = coin.websiteUrl
            
            //self.cryptoDetailIconImage
            self.cryptoDetailNameLabel.textColor = UIColor(hex: "#f7931A")
            self.cryptoDetailNameLabel.text = coin.name
            self.cryptoDetailSymbolLabel.text = coin.symbol
            self.cryptoDetailPriceLabel.text = String(format: "%.2f", coin.price)
            self.cryptoDetailMarketCapLabel.text = "\(coin.marketCap)"
            self.cryptoDetailLabel.text = coin.description
                        
            // TODO: show coin Detail
//            self.coinDetailViewHighCon.constant =  CGFloat(self.coinDetailView.bounds.height)
//            self.showDetail()
            
        }, errorHandler: { (errorCode, errorDesc) in
        })        
    }

//    func showDetail() {
////        self.coinDetailViewHighCon.constant =  CGFloat(self.coinDetailView.bounds.height)
//        self.content.addSubview(self.coinDetailView)
//    }
    
    func hideDetail() {
        self.coinDetailViewHighCon.constant = 0
        self.content.removeFromSuperview()
    }
    
    
    @IBAction func touchGoToWebsiteButton(_ sender: Any) {
        if let linkUrl = self.link, let url = URL(string: linkUrl) {
            UIApplication.shared.openURL(url)
        }
    }
    

}


