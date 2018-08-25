//
//  CoinApiWebSocket.swift
//  CryptoCurrencyFeed
//
//  Created by Joseph Missamore on 8/23/18.
//  Copyright © 2018 Joseph Missamore. All rights reserved.
//

import Foundation
import Starscream

class CoinApiWebSocket: WebSocketDelegate {
    static let shared = CoinApiWebSocket()
    let socket: WebSocket
    var trades = [TradeModel]()
    
    init() {
        socket = WebSocket(url: URL(string: "wss://ws.coinapi.io/v1/")!)
        socket.delegate = self
        }
    
    
    
    
    
    let helloMessage : [String: Any] = [
        "type": "hello",
        "apikey": NetworkSingleton.shared.COIN_API_KEY,
        "heartbeat": false,
        "subscribe_data_type": ["trade"],
        "subscribe_filter_symbol_id": [
            "BITSTAMP_SPOT_BTC_USD",
        ]
    ]
    
    
    
    func makeInitPost() {
        do {
            let data = try JSONSerialization.data(withJSONObject: helloMessage, options: [])
            socket.write(data: data)
            print("wrote to socket")
            
        } catch  {
            print(error)
        }
    }
    
    internal func websocketDidConnect(socket: WebSocketClient) {
        print("Socket did connect")
        makeInitPost()
    }

    internal func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("websocket is disconnected: \(error?.localizedDescription ?? "Timed Out")")
    }

    internal func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("received message: \(text)")
        
        let json = text.data(using: .utf8)!
        let decoder = JSONDecoder()
        do {
            let tradeData = try decoder.decode(TradeModel.self, from: json)
            print(tradeData)
        } catch {
            print("Error convering to JSON")
        }
    }

    internal func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("Data received: \(data)")
    }
    
}
