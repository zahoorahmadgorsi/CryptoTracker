//
//  CryptoRate.swift
//  CryptoTracker
//
//  Created by iMac on 29/01/2022.
//

import Foundation

struct CryptoRate: Codable {
    var time: Time
    var bpi: BPI
    
    enum CodingKeys: String, CodingKey {
        case time = "time"
        case bpi = "bpi"
    }
    
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            time = try values.decode(Time.self, forKey: .time)
            bpi = try values.decode(BPI.self, forKey: .bpi)
        } catch {
//            Crashlytics.crashlytics().record(error: error)
            throw error
        }
    }
}

struct Time: Codable{
    let updated: String
    let updatedISO: String
    let updateduk: String?
    
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            updated = try values.decode(String.self, forKey: .updated)
            updatedISO = try values.decode(String.self, forKey: .updatedISO)
            updateduk = try values.decodeIfPresent(String.self, forKey: .updateduk)
        } catch {
//            Crashlytics.crashlytics().record(error: error)
            throw error
        }
    }
}

struct BPI: Codable{
    let USD: Currency
    let GBP: Currency
    let EUR: Currency
    
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            USD = try values.decode(Currency.self, forKey: .USD)
            GBP = try values.decode(Currency.self, forKey: .GBP)
            EUR = try values.decode(Currency.self, forKey: .EUR)
        } catch {
//            Crashlytics.crashlytics().record(error: error)
            throw error
        }
    }
}


struct Currency: Codable{
    let code: String
    let symbol: String
    let rate: String
    let description: String
    let rate_float: Float
    
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            code = try values.decode(String.self, forKey: .code)
            symbol = try values.decode(String.self, forKey: .symbol)
            rate = try values.decode(String.self, forKey: .rate)
            description = try values.decode(String.self, forKey: .description)
            rate_float = try values.decode(Float.self, forKey: .rate_float)
        } catch {
//            Crashlytics.crashlytics().record(error: error)
            throw error
        }
    }
}

