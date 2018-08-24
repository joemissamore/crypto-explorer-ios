//
//  ViewController.swift
//  CryptoCurrencyFeed
//
//  Created by Joseph Missamore on 8/23/18.
//  Copyright © 2018 Joseph Missamore. All rights reserved.
//

import UIKit
import Starscream

class ViewController: UIViewController, WebSocketDelegate {
//    let WEBSOCKET_URL =  "wss://ws.coinapi.io/v1/"
    let socket = WebSocket(url: URL(string: "wss://ws.coinapi.io/v1/")!)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        socket.delegate = self
        socket.connect()
        
//        if socket.isConnected {
//            print("socket is connected")
//            makeInitPost(helloMessage)
//        }
    }
    
    
    let helloMessage : [String: Any] = [
        "type": "hello",
        "apikey": NetworkSingleton.shared.COIN_API_KEY,
        "heartbeat": false,
        "subscribe_data_type": ["trade"],
        "subscribe_filter_symbol_id": [
            "BITSTAMP_SPOT_BTC_USD",
            "BITFINEX_SPOT_BTC_LTC",
            "COINBASE_",
            "ITBIT_"
        ]
    ]
    
    
    
    private func makeInitPost(_ json: [String: Any]) {
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            socket.write(data: data)
            print("wrote to socket")
    
        } catch  {
            print(error)
        }
    }
    
}



// MARK -- Websocket

extension ViewController {
    func websocketDidConnect(socket: WebSocketClient) {
        print("Socket did connect")
        makeInitPost(helloMessage)
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("websocket is disconnected: \(error?.localizedDescription ?? "Error")")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("received message: \(text)")
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("got some data: \(data)")
    }
}
