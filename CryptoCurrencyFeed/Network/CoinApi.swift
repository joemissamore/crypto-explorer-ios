//
//  CoinApi.swift
//  CryptoCurrencyFeed
//
//  Created by Joseph Missamore on 8/27/18.
//  Copyright © 2018 Joseph Missamore. All rights reserved.
//

import Starscream




/**
    Delegate for receiving messages
    from the websocket.
 */
protocol CoinApiWebsocketDelegate {
    func didReceiveMessage(trade: TradeModel)
}


/**
 
 Example use:
 CoinApiWebSocket.shared.connect()
 Use the CoinApiWebsocketDelegate to handle the messages received from
 the websocket.
 
 After the connection is established the func websocketDidConnect
 is called which in return calles the func makeInitPost.
 
 - Important: Delegate: CoinApiWebsocketDelegate
 
 - Returns: Nothing
 
 */
class CoinApiWebSocket {
    /**
        Websocket singleton
     */
    static let shared = CoinApiWebSocket()
    
    private let socket: WebSocket
    var websocketMessageDelegate: CoinApiWebsocketDelegate!
    
    init() {
        socket = WebSocket(url: URL(string: "wss://ws.coinapi.io/v1/")!)
        socket.delegate = self
    }
    
    
    /// Function wrapper for
    /// socket.connect()
    func connect() {
        socket.connect()
    }
    
    /// Message sent to websocket
    /// If heartbeat is set to false
    /// the connection will most likely die.
    /// The Websocket framework handles the
    /// ping/pong.
    let helloMessage : [String: Any] = [
        "type": "hello",
        "apikey": NetworkSingleton.shared.COIN_API_KEY,
        "heartbeat": true,
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
}


/// Websocket delegates
/// These are internal methods because
/// the WebSoketDelegate needs access to them
/// and thus cant be private methods.
extension CoinApiWebSocket: WebSocketDelegate {
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
            websocketMessageDelegate.didReceiveMessage(trade: tradeData)
        } catch {
            print("Error convering to JSON")
        }
    }
    
    internal func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("Data received: \(data)")
    }
}






let baseUrl = "https://p1963.mocklab.io"

/// Test function that returns
/// an accurate representation of JSON from an external source.
func fetchTrades(_ completionHandler: @escaping(TradeModel?, Error?) -> ()) {
    let urlString = "https://p1963.mocklab.io/test/"
    let url = URL(string: urlString)
    
    URLSession.shared.dataTask(with: url!) { (data, response, error) -> Void in
        guard let data = data else {
            print("error... \(error?.localizedDescription)")
            completionHandler(nil, error)
            return
        }
        
        let decoder = JSONDecoder()
        do {
            /// TODO: Parse this in a function according to the reponse
            /// type.
            let trades = try decoder.decode(TradeModel.self, from: data)
            DispatchQueue.main.async {
                completionHandler(trades, nil)
            }
        } catch {
            print("couldnt decode... \(error.localizedDescription)")
        }
        
        }.resume()
}



/// For testing and recieving a list of marketplaces for
/// the user to select.
/// - Returns: A list of exchanges
func fetchMarketPlaces(_ completionHandler: @escaping ([ExchangeModel]?, Error?) -> ()) {
    let urlString = baseUrl + "/list-all-exchanges/"
    let url = URL(string: urlString)
    
    URLSession.shared.dataTask(with: url!) { (data, response, error) in
        guard let data = data else {
            print("error fetching list of market places...")
            completionHandler(nil, error)
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let exchanges = try decoder.decode([ExchangeModel].self, from: data)
            DispatchQueue.main.async {
                completionHandler(exchanges, nil)
            }
            
        }
        catch {
            print("couldn't decode information")
        }
    }.resume()
    
}

func fetchFromApi(url: URL, _ completionHandler: @escaping (Data?, Error?) -> ()) {
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let data = data else {
            print("error fetching items")
            completionHandler(nil, error)
            return
        }
        DispatchQueue.main.async {
            completionHandler(data, nil)
        }
        
    }.resume()
}








