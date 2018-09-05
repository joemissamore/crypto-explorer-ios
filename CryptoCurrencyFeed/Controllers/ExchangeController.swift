//
//  ExchangeController.swift
//  CryptoCurrencyFeed
//
//  Created by Joseph Missamore on 8/28/18.
//  Copyright © 2018 Joseph Missamore. All rights reserved.
//

import UIKit

class ExchangeController: UITableViewController {
    
    private let exchangeCellId = "exchangeCellId"
    
    var exchanges = [ExchangeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        tableView.register(ExchangeCell.self, forCellReuseIdentifier: exchangeCellId)
        
        fetchMarketPlaces { (exchanges, error) in
            if let exchanges = exchanges {
                self.exchanges = exchanges
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: exchangeCellId, for: indexPath) as! ExchangeCell
        cell.exchange = exchanges[indexPath.item]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchanges.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            
            
            // Need to make api call
            let url = URL(string: NetworkSingleton.shared.TEST_FETCH_ASSETS)
            fetchFromApi(url: url!) { (data, error) in
                guard let data = data else {
                    print(error?.localizedDescription)
                    return
                }

                do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let exchangeAsset = try decoder.decode([ExchangeAssetsModel].self, from: data)
                        let exchangeAssetsControleler = ExchangeAssetsController()
                        exchangeAssetsControleler.exchangeAssetInfo = exchangeAsset
                        self.navigationController?.pushViewController(exchangeAssetsControleler, animated: true)
                } catch {
                    print("reached error...")
                    
                }
                
             
            }
            
            
            
            
            
//            if cell.accessoryType == .checkmark {
//                cell.accessoryType = .disclosureIndicator
//            } else {
//                cell.accessoryType = .checkmark
//            }
        }
        
        
    }
    
    
    
//    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
//        return false
//    }
}





class ExchangeCell: UITableViewCell {
    
    
    var exchange: ExchangeModel? {
        didSet {
            exchangeNameLabel.text = exchange?.name
        }
    }
    
    let exchangeNameLabel = UILabel()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        selectionStyle = UITableViewCellSelectionStyle.none
        
        exchangeNameLabel.textColor = .white
        
        addSubview(exchangeNameLabel)
        
        exchangeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        exchangeNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        exchangeNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        
    }
    
}
