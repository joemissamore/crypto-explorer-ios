//
//  TradeInformation.swift
//  CryptoCurrencyFeed
//
//  Created by Joseph Missamore on 8/23/18.
//  Copyright © 2018 Joseph Missamore. All rights reserved.
//

class TradeModel: Decodable {
    
    /*
     {
     "type": "trade", //
     "symbol_id": "BITSTAMP_SPOT_BTC_USD", //
     "sequence": 2323346,
     "time_exchange": "2013-09-28T22:40:50.0000000Z", //
     "time_coinapi": "2017-03-18T22:42:21.3763342Z",
     "uuid": "770C7A3B-7258-4441-8182-83740F3E2457",
     "price": 770.000000000,
     "size": 0.050000000,
     "taker_side": "BUY"
     }
     
     
     SPOT    {exchange_id}_SPOT_{asset_id_base}_{asset_id_quote}
     "BITSTAMP_SPOT_BTC_USD",
     
     */
    
    var symbolIdentifier: SymbolIdenifier!
    var takerSideId: TakerSideId!
    
    var timeExchange: String
    var type: String
    var timeCoinapi: String
    var uuid: String
    var price: Double
    var size: Double
    var takerSide: String
    var symbolId: String
    var sequence: Int
    
    var exchangeId: String?
    var assetIdBase: String?
    var assetIdQuote: String?
    
    enum CodingKeys : String, CodingKey {
        case timeExchange = "time_exchange"
        case timeCoinapi = "time_coinapi"
        case takerSide = "taker_side"
        case symbolId = "symbol_id"
        
        case type
        case uuid
        case price
        case size
        case sequence
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.timeExchange = try values.decode(String.self, forKey: .timeExchange)
        self.type = try values.decode(String.self, forKey: .type)
        self.timeCoinapi = try values.decode(String.self, forKey: .timeCoinapi)
        self.uuid = try values.decode(String.self, forKey: .uuid)
        self.symbolId = try values.decode(String.self, forKey: .symbolId)
        self.sequence = try values.decode(Int.self, forKey: .sequence)
        self.price = try values.decode(Double.self, forKey: .price)
        self.size = try values.decode(Double.self, forKey: .size)
        self.takerSide = try values.decode(String.self, forKey: .takerSide)
        
        tradeType(self.symbolId)
    }
    

    
    func tradeType(_ symbols: String) -> Void {
        let parsedSymbols = symbols.components(separatedBy: "_")
        let typeOfSymbol = parsedSymbols[1]
        
        switch typeOfSymbol {
        case "SPOT":
            exchangeId = parsedSymbols[0]
            assetIdBase = parsedSymbols[2]
            assetIdQuote = parsedSymbols[3]
            symbolIdentifier = .spot
            
        default:
            print("reached default case...")
        }
        
        switch self.takerSide {
        case "BUY":
            self.takerSideId = .buy
        case "SELL":
            self.takerSideId = .sell
        case "BUY_ESTIMATED":
            self.takerSide = "EST. BUY"
            self.takerSideId = .buyEstimated
        case "SELL_ESTIMATED":
            self.takerSide = "EST. SELL"
            self.takerSideId = .sellEstimated
        default:
            self.takerSideId = .unknown
        }
    }
    
    enum SymbolIdenifier {
        case spot
    }
    
    enum TakerSideId {
        case buy
        case sell
        case buyEstimated
        case sellEstimated
        case unknown
    }
    
}
