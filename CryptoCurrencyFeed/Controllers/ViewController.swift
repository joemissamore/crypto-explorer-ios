//
//  ViewController.swift
//  CryptoCurrencyFeed
//
//  Created by Joseph Missamore on 8/23/18.
//  Copyright © 2018 Joseph Missamore. All rights reserved.
//

import UIKit



class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    
    let tradeCellIdentifier = "tradeCellIdentifier"
    var trades = [TradeModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .black
        CoinApiWebSocket.shared.websocketMessageDelegate = self
        
        
        
        collectionView?.register(TradeCell.self, forCellWithReuseIdentifier: tradeCellIdentifier)
        
//          TESTING
//        fetchTrades { (trades, error) in
//            if let trades = trades {
//                var tradeList = [TradeModel]()
//                tradeList.append(trades)
//                self.trades = tradeList
//                self.collectionView?.reloadData()
//            }
//            else if let error = error {
//                print(error.localizedDescription)
//            }
//
//        }
        
        
        
        CoinApiWebSocket.shared.connect()
        
//        fetchMarketPlaces { (exchanges, error) in
//
//        }
    }
    
    private func setCellColor(tradeCell: TradeCell, textColor: UIColor) {
        let allCells = tradeCell.getAllCells()
        allCells.forEach {
            $0.textColor = textColor
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tradeCell = collectionView.dequeueReusableCell(withReuseIdentifier: tradeCellIdentifier, for: indexPath) as! TradeCell
        
        let tradeInfo = trades[indexPath.item]
        
        print(tradeInfo.takerSideId)
        switch tradeInfo.takerSideId {
        case .buy:
            setCellColor(tradeCell: tradeCell, textColor: .red)
        case .sell:
            setCellColor(tradeCell: tradeCell, textColor: .green)
        case .buyEstimated:
            setCellColor(tradeCell: tradeCell, textColor: .orange)
        case .sellEstimated:
            setCellColor(tradeCell: tradeCell, textColor: .blue)
        default:
            setCellColor(tradeCell: tradeCell, textColor: .white)
        }
    
        
        tradeCell.cell1.text = tradeInfo.takerSide
        tradeCell.cell2.text = tradeInfo.exchangeId
        tradeCell.cell3.text = String(tradeInfo.price)
        tradeCell.cell4.text = String(tradeInfo.size)
        tradeCell.cell5.text = tradeInfo.assetIdBase
        tradeCell.cell6.text = tradeInfo.assetIdQuote
        
        
        return tradeCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trades.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }

}





extension ViewController: CoinApiWebsocketDelegate {
    func didReceiveMessage(trade: TradeModel) {
        DispatchQueue.main.async {
            self.trades.insert(trade, at: 0)
            self.collectionView?.reloadData()
        }
        
    }
    
    
}











class TradeCell: UICollectionViewCell {
    
    let cellContainer = UIView()
    
    /* Get size of screen */
    let screenWidth = UIScreen.main.bounds.size.width
//    var cellWidth : CGFloat
    
    let cell1 : UILabel = UILabel()
    let cell2 : UILabel = UILabel()
    let cell3 : UILabel = UILabel()
    let cell4 : UILabel = UILabel()
    let cell5 : UILabel = UILabel()
    let cell6 : UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor =  .red
        
        setupViews()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func getAllCells() -> [UILabel] {
        return [cell1, cell2, cell3, cell4, cell5, cell6]
    }
    
    func setupViews() {
        
        cellContainer.translatesAutoresizingMaskIntoConstraints = false
//        cellContainer.backgroundColor = .yellow

        contentView.addSubview(cellContainer)

        
        [cell1, cell2, cell3, cell4, cell5, cell6].forEach {
            $0.font = .boldSystemFont(ofSize: 10)
            $0.adjustsFontSizeToFitWidth = true
            cellContainer.addSubview($0)
        }
        
        
        
        
        cell1.anchor(top: cellContainer.topAnchor, leading: cellContainer.leadingAnchor, trailing: nil, bottom: cellContainer.bottomAnchor)
        cell1.widthAnchor.constraint(equalTo: cellContainer.widthAnchor, multiplier: 0.20).isActive = true
        
        cell2.anchor(top: cellContainer.topAnchor, leading: cell1.trailingAnchor, trailing: nil, bottom: cellContainer.bottomAnchor)
        cell2.widthAnchor.constraint(equalTo: cellContainer.widthAnchor, multiplier: 0.25).isActive = true
        
        // Fiat amount
        cell3.anchor(top: cellContainer.topAnchor, leading: cell2.trailingAnchor, trailing: nil, bottom: cellContainer.bottomAnchor)
        cell3.widthAnchor.constraint(equalTo: cellContainer.widthAnchor, multiplier: 0.20).isActive = true
        
        // Crypto amount
        cell4.anchor(top: cellContainer.topAnchor, leading: cell3.trailingAnchor, trailing: nil, bottom: cellContainer.bottomAnchor)
        cell4.widthAnchor.constraint(equalTo: cellContainer.widthAnchor, multiplier: 0.20).isActive = true
        
        cell5.anchor(top: cellContainer.topAnchor, leading: cell4.trailingAnchor, trailing: nil, bottom: cellContainer.bottomAnchor)
        cell5.widthAnchor.constraint(equalTo: cellContainer.widthAnchor, multiplier: 0.07).isActive = true
        
        cell6.anchor(top: cellContainer.topAnchor, leading: cell5.trailingAnchor, trailing: nil, bottom: cellContainer.bottomAnchor)
        cell6.widthAnchor.constraint(equalTo: cellContainer.widthAnchor, multiplier: 0.07).isActive = true
        
        
        NSLayoutConstraint.activate([
            
            cellContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellContainer.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cellContainer.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            cellContainer.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.95),
        ])
    }
    
}





extension UIView {
    
    func fillSuperView() {
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, trailing: superview?.trailingAnchor, bottom: superview?.bottomAnchor)
    }
    
    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
    }
}
