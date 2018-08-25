//
//  CryptoCompareWebSocket.swift
//  CryptoCurrencyFeed
//
//  Created by Joseph Missamore on 8/23/18.
//  Copyright © 2018 Joseph Missamore. All rights reserved.
//

import Foundation
import SocketIO

class CryptoCompareWebSocket {
    static let shared = CryptoCompareWebSocket()
//    let cryptoCompareURL = "wss://streamer.cryptocompare.com/socket.io/?transport=websocket"
    var manager : SocketManager
//    var socket : SocketIOClient
    init() {
        manager = SocketManager(socketURL: URL(string: "https://streamer.cryptocompare.com/")!, config: [.log(true), .compress])
    }
    
    
    
    func connect() {
        manager.defaultSocket.on("connect") { (_, _) in
            self.emitters()
        }
        
        manager.defaultSocket.connect()
    }
    
    func emitters() -> Void {
        manager.defaultSocket.emit("SubAdd", ["subs": ["5~CCCAGG~BTC~USD", "5~CCCAGG~ETH~USD", "11~BTC", "11~ETH"]])
        manager.defaultSocket.on("m") { (data, ack) in
            print("data... \(data[0])")
        }
    }
    
    
//    func parser(data: ) {
//        print(data)
//    }
    
}


class TradeInformation {
    var subscriptionID: Int
    var exchangeName: String
    var fromSymbol: String
    var toSymbol: String
    
    init(subId: Int, exName: String, fromSym: String, toSym: String) {
        self.subscriptionID = subId
        self.exchangeName = exName
        self.fromSymbol = fromSym
        self.toSymbol = toSym
    }
    
    
}
