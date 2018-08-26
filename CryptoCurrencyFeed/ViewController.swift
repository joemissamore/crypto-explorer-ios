//
//  ViewController.swift
//  CryptoCurrencyFeed
//
//  Created by Joseph Missamore on 8/23/18.
//  Copyright © 2018 Joseph Missamore. All rights reserved.
//

import UIKit
import SocketIO

/*
 UICollectionViewDelegate //
 
 UICollectionViewDataSource //
 
 UICollectionViewDelegateFlowLayout
 */
class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let tradeCellIdentifier = "tradeCellIdentifier"
    
    var trades = [TradeInformation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .blue
        CryptoCompareWebSocket.shared.connect { (isConnected) in
            if (isConnected) {
                CryptoCompareWebSocket.shared.emitters()
            }
            else {
                print("couldnt connect")
            }
        }
        
        CryptoCompareWebSocket.shared.listenToChannelAndParse { (tradeInformation) in
//            print("trade info... \(tradeInformation.cryptoCurrencyType)")
            self.trades.insert(tradeInformation, at: 0)
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }

        }

        collectionView?.register(TradeCell.self, forCellWithReuseIdentifier: tradeCellIdentifier)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tradeCell = collectionView.dequeueReusableCell(withReuseIdentifier: tradeCellIdentifier, for: indexPath) as! TradeCell
        
        let cryptoType = trades[indexPath.item].cryptoCurrencyType
        let fiatType = trades[indexPath.item].fiatCurrencyType
        let transType = trades[indexPath.item].transactionType
        
        tradeCell.row1.text = cryptoType + "\t" + fiatType + "\t" + transType
        return tradeCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trades.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }

}


class TradeCell: UICollectionViewCell {
    let row1 = UILabel()
    let row2 = UILabel()
//    var fiatCurrencyType : UILabel
//    var transactionType: UILabel
//    var tradeId: UILabel
//    var timeStamp: UILabel
//    var quantity: UILabel
//    var price: UILabel
//    var total: UILabel
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor =  .red
        setupViews()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        row1.translatesAutoresizingMaskIntoConstraints = false
        row2.translatesAutoresizingMaskIntoConstraints = false
        addSubview(row1)
        addSubview(row2)
        NSLayoutConstraint.activate([
            row1.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            row1.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
        ])
    }
}
