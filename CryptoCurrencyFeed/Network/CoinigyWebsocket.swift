//
//  CoinigyWebsocket.swift
//  CryptoCurrencyFeed
//
//  Created by Joseph Missamore on 8/23/18.
//  Copyright © 2018 Joseph Missamore. All rights reserved.
//

import Foundation
import ScClient

class CoingyWebsocket {
    static let shared = CoingyWebsocket()
    let client = ScClient(url: "http://private-anon-05ca94a375-coinigy.apiary-mock.com")
    
    let onConnect = {
        (client: ScClient) in
            print("Connected to server")
    }
    
    let onDisconnect = {
        (client: ScClient, error: Error?) in
            print("Disconnected from server error: \(error?.localizedDescription)")
    }
    
    func connect() {
        client.connect()
        
    }
    
    func setupSocket() {
        client.setBasicListener(onConnect: onConnect, onConnectError: nil, onDisconnect: onDisconnect)
    }
    
    
}
