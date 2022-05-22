//
//  ViewController.swift
//  Coins
//
//  Created by Sakaoduean Thichaem on 16/5/2565 BE.
//

import UIKit
import AlamofireImage
import WebKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var coinsTable: UITableView!
    @IBOutlet weak var TopRankCollection: UICollectionView!
    @IBOutlet weak var amountTopRankLabel: UILabel!
    @IBOutlet weak var coins2table: UICollectionView!
//    @IBOutlet weak var coinsCollectionWidthCon: NSLayoutConstraint!
    
    var coins = [Coins]()
    let amountTopRank = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        self.getCoins()
        self.amountTopRankLabel.text = "\(self.amountTopRank)"
        print("som: 1")
        
//        self.coins2table.register(UINib(nibName: "CCell", bundle: .main), forCellWithReuseIdentifier: "CoinsCell")
         self.coins2table.register(UINib(nibName: "CoinsCell", bundle: nil), forCellWithReuseIdentifier: "CCell")

        
    }
    
    // MARK: Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("som: 2")
        print("som: count table:", self.coins.count)
        return self.coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let coin = self.coins[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CoinCell
        //
        //let urlRequest = URLRequest(url: URL(string: "https://cdn.coinranking.com/bOabBYkcX/bitcoin_btc.svg")!)
        //cell.iconWebView.load(urlRequest)        
        //
        
        cell.fullNameCryptoLabel.text = "[\(coin.rank)]" + coin.name
        cell.nameCryptoLabel.text = coin.symbol
        cell.priceCryptoLabel.text = String(format: "%.5f", coin.price)
                
        var allow = ""
        if coin.change >= 0 { //geen
            allow = "↑"
            cell.priceUpDownCryptoLabel.textColor = .systemGreen
        } else { //red
            allow = "↓"
            cell.priceUpDownCryptoLabel.textColor = .systemRed
        }
        cell.priceUpDownCryptoLabel.text = allow + String(format: "%.2f", coin.change)
        
        
        return cell
    }
    
    // MARK: Collection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.TopRankCollection {
            return self.amountTopRank
        } else if collectionView == self.coins2table {
            return self.coins.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == self.coins2table {
            let cell : CoinsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CCell", for: indexPath) as! CoinsCell

//            let nib = UINib(nibName: "CoinsCell", bundle: nil)
//            collectionView.register(nib, forCellWithReuseIdentifier: "CoinsCell") // I don't know who is the collectionView
            
//            var cell : CoinsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CCell", for: indexPath) as! CoinsCell


//            let cell: CoinsCell //collectionView.dequeueReusableCell(withReuseIdentifier: "CCell", for: indexPath) as! CoinsCell
//            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CCell", for: indexPath) as! CoinsCell
//            let coin = self.coins[indexPath.row]
//            cell.fullNameCryptoLabel.text = coin.name
//            cell.nameCryptoLabel.text = coin.symbol
            
//            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//            layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
//            layout.itemSize = CGSize(width: collectionView.frame.width/3, height: collectionView.frame.width/3)
//            collectionView.collectionViewLayout = layout
            return cell
            
        } else {
//            let coin = self.coins[indexPath.row]
            print(self.coins.count)
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TopCoinCell
            //-cryptoImageView
            //let urlRequest = URLRequest(url: URL(string: "https://cdn.coinranking.com/bOabBYkcX/bitcoin_btc.svg")!)
            //cell.iconWebView.load(urlRequest)
//            cell.fullNameCryptoLabel.text = coin.name
//            cell.nameCryptoLabel.text = coin.symbol
//            //cell.priceUpDownCryptoImageView
//            cell.priceUpDownCryptoLabel.text = "\(coin.change)"
            return cell

        }
        
        
    }
    
    func getCoins() { //limit offset
        ServerConnector.call("coins", parameters: nil, completionHandler: { (data) in
            self.coins = Coins.coinsFromJSONArray(data)
            print("som: count table2:", self.coins.count)
            self.coinsTable.reloadData()
            self.TopRankCollection.reloadData()
            self.coins2table.reloadData()
            //completionHandler?(moreMessages)
        }, errorHandler: { (errorCode, errorDesc) in
            //errorHandler?()
        })
    }

    

}


