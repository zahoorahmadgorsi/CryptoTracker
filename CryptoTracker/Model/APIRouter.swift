//
//  APIRouter.swift
//  CryptoTracker
//
//  Created by iMac on 29/01/2022.
//

import UIKit
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    //https://api.coindesk.com/v1/bpi/currentprice.json
    // Obtain backend URL from configuration
    static let baseURLString: String = {
        guard let urlString = Bundle.main.object(forInfoDictionaryKey: "BACKEND_URL") as? String else {
            return ""
        }
        return urlString
    }()

    static let apiVersion: String = {
        guard let urlString = Bundle.main.object(forInfoDictionaryKey: "BACKEND_API_VERSION") as? String else {
            return ""
        }
        return "/" + urlString
    }()

    static let scheme: String = {
        guard let scheme = Bundle.main.object(forInfoDictionaryKey: "BACKEND_SCHEME") as? String else {
            return "https"
        }
        return scheme
    }()

    case getCurrentCryptoRates
    
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            return getHTTPMethod()
        }

        let requestUrl: URL = {
            getRequestURL()
        }()

        let body: Data? = {
            getBodyData()
        }()

        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = body
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        return urlRequest
    }

    func getHTTPMethod() -> HTTPMethod {
        switch self {
            case .getCurrentCryptoRates:
                return .get
        }
    }

    fileprivate func getRequestURL() -> URL {
        var newURLComponents = URLComponents()
        newURLComponents.scheme = APIRouter.scheme
        newURLComponents.host = APIRouter.baseURLString
        newURLComponents.path = APIRouter.apiVersion

        switch self {
        case .getCurrentCryptoRates:
            newURLComponents.path.append("/bpi/currentprice.json")
        }
        
        do {
            let callURL = try newURLComponents.asURL()
            return callURL
        } catch {
//            Crashlytics.crashlytics().record(error: error)
        }
        return URL(string: "https://\(APIRouter.baseURLString)")!
    }
    
    fileprivate func getBodyData() -> Data? {
        switch self {
            case .getCurrentCryptoRates:
                return nil
//            case let .setFavourites(token, id):
//                return getFavouritesAsJSONData(token: token , id : id)
        }
    }
    
//    fileprivate func getFavouritesAsJSONData(token: String , id : Int) -> Data? {
//        let body: [String: Any] = [
//            "id": id,
//            "token": token
//        ]
//        return try? JSONSerialization.data(withJSONObject: body, options: [])
//    }
     
}

