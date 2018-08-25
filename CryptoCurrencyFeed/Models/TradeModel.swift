//
//  TradeModel.swift
//  CryptoCurrencyFeed
//
//  Created by Joseph Missamore on 8/23/18.
//  Copyright © 2018 Joseph Missamore. All rights reserved.
//

import Foundation

class TradeModel: Decodable {
    var timeExchange: String
//    var timeCoinapi: String
//    var uuid: String
//    var price: Float
//    var size: Double
//    var takerSide: String
//    var symbolId: String
//    var sequence: String
//    var type: String
    
    enum CodingKeys : String, CodingKey {
        case timeExchange = "time_exchange"
//        case timeCoinapi = "time_coin_api"
//        case takerSide = "taker_side"
//        case symbolId = "symbol_id"
        
//        case uuid
//        case price
//        case size
//        case sequence
//        case type
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.timeExchange = try values.decode(String.self, forKey: .timeExchange)
//        self.timeCoinapi = try values.decode(String.self, forKey: .timeCoinapi)
//        self.uuid = try values.decode(String.self, forKey: .uuid)
//        self.price = try values.decode(Float.self, forKey: .price)
//        self.size = try values.decode(Double.self, forKey: .size)
//        self.takerSide = try values.decode(String.self, forKey: .takerSide)
//        self.symbolId = try values.decode(String.self, forKey: .symbolId)
//        self.sequence = try values.decode(String.self, forKey: .sequence)
//        self.type = try values.decode(String.self, forKey: .type)
    }
    
    
}
