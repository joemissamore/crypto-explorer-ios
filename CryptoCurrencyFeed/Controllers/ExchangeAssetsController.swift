//
//  ExchangeAssetsController.swift
//  CryptoCurrencyFeed
//
//  Created by Joseph Missamore on 8/30/18.
//  Copyright © 2018 Joseph Missamore. All rights reserved.
//

// TODO: SEARCH BAR

import UIKit
class ExchangeAssetsController: UITableViewController {
    let exchangeAssetsCellString = "exchangeAssetsCell"
 
    
    var exchangeAssetInfo: [ExchangeAssetsModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        tableView.register(ExchangeAssetsCell.self, forCellReuseIdentifier: exchangeAssetsCellString)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! ExchangeAssetsCell
        
        if cell.accessoryType == .checkmark {
            cell.accessoryType = .none
        } else {
            cell.accessoryType = .checkmark
            UserDefaults.standard.set(cell.assetInformation?.assetIdBase, forKey: "selectedCurrency")
            print(UserDefaults.standard.dictionaryRepresentation())
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: exchangeAssetsCellString, for: indexPath) as! ExchangeAssetsCell
        cell.assetInformation = exchangeAssetInfo?[indexPath.item]
        
        let selectedCells = UserDefaults.standard.array(forKey: "selectedCurrency") as! [ExchangeAssetsUserDefault]
        
        for sCell in selectedCells {
            if (sCell.assetIdBase == cell.assetInformation?.assetIdBase
                && sCell.assetIdQuote == cell.assetInformation?.assetIdQuote)
            {
                cell.accessoryType = .checkmark
                break
            }
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = exchangeAssetInfo?.count {
            return count
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}





class ExchangeAssetsCell: UITableViewCell {
    
    let label = UILabel()
    
    var assetInformation: ExchangeAssetsModel? {
        didSet {
            var baseString: String = ""
            if let assetIdQuote = assetInformation?.assetIdQuote {
                baseString = assetIdQuote
            } else {
                baseString = "err. missing assetIdQuote"
            }
            baseString += "/"
            if let assetIdBase = assetInformation?.assetIdBase {
                baseString += assetIdBase
            } else {
                baseString += "err. missing assetIdBase"
            }
            
            
            label.text = baseString
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = UITableViewCellSelectionStyle.none
        backgroundColor = .black
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 12)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        
        
    }
    
    
}
