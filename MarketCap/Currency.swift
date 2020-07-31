//
//  Currency.swift
//  MarketCap
//
//  Created by Denis on 01.08.2020.
//  Copyright © 2020 Denis Voropaev. All rights reserved.
//

import Foundation

public struct Roi: Decodable {

    //    "times": 39.58767558324263,
    //    "currency": "btc",
    //    "percentage": 3958.7675583242626

    public var times: Double?
    public var currency: String?
    public var percentage: Double?
}

public struct Currency: Decodable, Identifiable {

    public var id: String
    public var name: String
    public var symbol: String
    public var rank: Int?
    public var image: String?
    public var cap: Int64?
    public var volume: Double?
    public var price: Double?
    public var high: Double?
    public var low: Double?
    public var priceChange: Double?
    public var priceChangePercent: Double?
    public var capChange: Double?
    public var capChangePercent: Double?
    public var totalSupply: Double?
    public var circulatingSupply: Double?
    public var allTimeHigh: Double?
    public var allTimeHighCangePercent: Double?
    public var allTimeHighDate: Date?
    public var allTimeLow: Double?
    public var allTimeLowChangePercent: Double?
    public var allTimeLowDate: Date?
    public var roi: Roi?
    public var updated: Date?
    
    enum CodingKeys: String, CodingKey {
        //    {
        //      "id": "bitcoin",
        //      "symbol": "btc",
        //      "name": "Bitcoin",
        //      "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
        //      "current_price": 11341.7,
        //      "market_cap": 209166049460,
        //      "market_cap_rank": 1,
        //      "total_volume": 22311462040,
        //      "high_24h": 11436.35,
        //      "low_24h": 10977.94,
        //      "price_change_24h": 206.54,
        //      "price_change_percentage_24h": 1.85488,
        //      "market_cap_change_24h": 3804217986,
        //      "market_cap_change_percentage_24h": 1.85245,
        //      "circulating_supply": 18447831,
        //      "total_supply": 21000000,
        //      "ath": 19665.39,
        //      "ath_change_percentage": -42.4899,
        //      "ath_date": "2017-12-16T00:00:00.000Z",
        //      "atl": 67.81,
        //      "atl_change_percentage": 16578.59446,
        //      "atl_date": "2013-07-06T00:00:00.000Z",
        //      "roi": null,
        //      "last_updated": "2020-07-31T20:17:04.385Z"
        //    }
        case id = "id"
        case name = "name"
        case symbol = "symbol"
        case image = "image"
        case price = "current_price"
        case cap = "market_cap"
        case rank = "market_cap_rank"
        case volume = "total_volume"
        case high = "high_24h"
        case low = "low_24h"
        case priceChange = "price_change_24h"
        case priceChangePercent = "price_change_percentage_24h"
        case capChange = "market_cap_change_24h"
        case capChangePercent = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case allTimeHigh = "ath"
        case allTimeHighCangePercent = "ath_change_percentage"
        case allTimeHighDate = "ath_date"
        case allTimeLow = "atl"
        case allTimeLowChangePercent = "atl_change_percentage"
        case allTimeLowDate = "atl_date"
        case roi = "roi"
        case updated = "last_updated"
    }
}
