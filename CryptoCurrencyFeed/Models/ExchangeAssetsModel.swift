//
//  ExchangeAssetsModel.swift
//  CryptoCurrencyFeed
//
//  Created by Joseph Missamore on 8/30/18.
//  Copyright © 2018 Joseph Missamore. All rights reserved.
//

import Foundation
struct ExchangeAssetsModel: Codable {
    var assetIdBase: String
    var assetIdQuote: String
    var dataEnd: String
    var dataOrderbookEnd: String
    var dataOrderbookStart: String
    var dataQuoteEnd: String
    var dataQuoteStart: String
    var dataStart: String
    var dataTradeEnd: String
    var dataTradeStart: String
    var exchangeId: String
    var symbolId: String
    var symbolType: String
}
