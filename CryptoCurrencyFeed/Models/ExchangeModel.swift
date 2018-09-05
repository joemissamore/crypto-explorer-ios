//
//  ExchangesModel.swift
//  CryptoCurrencyFeed
//
//  Created by Joseph Missamore on 8/28/18.
//  Copyright © 2018 Joseph Missamore. All rights reserved.
//

import Foundation
class ExchangeModel: Decodable {
    /*
         {
             "exchange_id": "BITSTAMP",
             "website": "https://www.bitstamp.net/",
             "name": "Bitstamp Ltd."
         }
     */
    
    var exchangeId: String
    var website: String
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case exchangeId = "exchange_id"
        
        case website
        case name
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.exchangeId = try values.decode(String.self, forKey: .exchangeId)
        self.website = try values.decode(String.self, forKey: .website)
        self.name = try values.decode(String.self, forKey: .name)
    }
    
    
}
