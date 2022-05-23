//
//  ServerConnector.swift
//  Coins
//
//  Created by Sakaoduean Thichaem on 19/5/2565 BE.
//

import Foundation
import SwiftyJSON
import Alamofire

class ServerConnector {
    
    
    static func call(_ path: String,
                     parameters: [String:Any]?,
                     retryCount:Int = 0,
                     coinCompletionHandler: (()->Void)? = nil,
                     completionHandler: ((JSON)->Void)?,
                     errorHandler: ((String?, String?) ->Void)?) {
        //
        var parameters = parameters
        if parameters == nil {
            parameters = [String:Any]()
        }
        parameters = ["limit": 20]
        
        var headers: HTTPHeaders?
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            headers = ["Platform" : "I", "App-Version" : appVersion]
        }
        
        let HTTP = "https" //"http"
        let DOMAIN = "api.coinranking.com"
        let PATH_FLODER = "/v2"
        //https://api.coinranking.com/v2/coins
        //https://api.coinranking.com/v2/coin/razxDUgYGNAdQ
        
        
//        parameters = ["limit": 24]
        
        Alamofire.request("\(HTTP)://\(DOMAIN)\(PATH_FLODER)/\(path)", method: .get, parameters: parameters).validate(contentType: ["application/json"])
            .validate()
            .responseJSON { response in
                switch response.result{
                case .success (let data):
                    let json = JSON(data)
                    
                    // check response code
                    switch json["status"].stringValue {
                    case "success":
                        let data = json["data"]
                        if data.exists() {
                            completionHandler?(data)
                        } else {
                            completionHandler?(JSON.null)
                        }
                    default: //"fail" or other
                        //let status = json["status"].stringValue
                        let type = json["type"].stringValue
                        let message = json["message"].stringValue
                        print("\(type):\(message)")
                        errorHandler?(type, message)
                    }
                    
                case .failure(let error):
                    // อย่าลืม show alert
                    print("Error: \(error)")
                    break
                }
        }
    }
}
