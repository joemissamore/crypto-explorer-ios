//
//  CryptoCompareWebSocket.swift
//  CryptoCurrencyFeed
//
//  Created by Joseph Missamore on 8/23/18.
//  Copyright © 2018 Joseph Missamore. All rights reserved.
//

import Foundation
import SocketIO


/*
 * This class is responsible for the websocket config
 */
class CryptoCompareWebSocket {
    static let shared = CryptoCompareWebSocket()
    var manager : SocketManager

    private init() {
        let url = URL(string: "https://streamer.cryptocompare.com/")!
        manager = SocketManager(socketURL: url, config: [.log(true), .compress])
    }
    
    
    func connect(isConnected: @escaping (Bool) -> ()) {
        manager.defaultSocket.on(clientEvent: .connect) { (_, _) in
            isConnected(true)
        }
        manager.defaultSocket.on(clientEvent: .disconnect) { (_, _) in
            isConnected(false)
        }
        manager.defaultSocket.connect()
    }
    
    
    

    func listenToChannelAndParse(completionHandler: @escaping (TradeInformation) -> ()) {
        manager.defaultSocket.on("m") { (data, _) in
        
            let channelInfo = data[0] as! String
            let channelInfoList = channelInfo.components(separatedBy: "~")
            
            switch (channelInfoList[0]){
                case "5": // aggregated data
                    let tradeInformation = TradeInformation(subId: "Aggregated Data", exName: channelInfoList[1], cryptoCurType: channelInfoList[2], fiatCurType: channelInfoList[3], transType: channelInfoList[4], tradeId: channelInfoList[5], timeStamp: channelInfoList[6], quantity: channelInfoList[7], price: channelInfoList[8], total: channelInfoList[9])
                    completionHandler(tradeInformation)
                default:
                    print("hit default case")
                
            }
            
            
            
            
        }
    }
    
    func emitters() -> Void {
//        manager.defaultSocket.emit("SubAdd", ["subs": ["5~CCCAGG~BTC~USD", "5~CCCAGG~ETH~USD", "11~BTC", "11~ETH"]])
        manager.defaultSocket.emit("SubAdd", ["subs": ["5~CCCAGG~BTC~USD", "5~CCCAGG~ETH~USD", "11~BTC", "11~ETH"]])
    }
}



class TradeInformation {
    // TODO:
    // Convert date
    /*
     * '{SubscriptionId}~{ExchangeName}~{CurrencySymbol}~{CurrencySymbol}~{Flag}~{TradeId}~{TimeStamp}~{Quantity}~{Price}~{Total}'
     * {Flag}
        1    Sell
        2    Buy
        4    Unknown
     */
    var subscriptionID: String
    var exchangeName: String
    var cryptoCurrencyType: String // BTC
    var fiatCurrencyType: String // USD
    var transactionType: String
    var tradeId: String
    var timeStamp: String
    var quantity: String
    var price: String
    var total: String
    
    init(subId: String,
         exName: String,
         cryptoCurType: String,
         fiatCurType: String,
         transType: String,
         tradeId: String,
         timeStamp: String,
         quantity: String,
         price: String,
         total: String) {
        
        self.subscriptionID = subId
        self.exchangeName = exName
        self.cryptoCurrencyType = cryptoCurType
        self.fiatCurrencyType = fiatCurType
        self.transactionType = TradeInformation.getTransActionType(transType)
        self.tradeId = tradeId
        self.timeStamp = timeStamp
        self.quantity = quantity
        self.price = price
        self.total = total
        
    }
    
    private static func getTransActionType(_ flag: String) -> String {
        switch flag {
        case "1":
            return "SELL"
        case "2":
            return "BUY"
        case "4":
            return "UNKNOWN"
        default:
            return "NOT REGISTERED"
        }
    }
    
    
}
