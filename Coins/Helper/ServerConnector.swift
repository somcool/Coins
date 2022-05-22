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
        //"\(HTTP)://\(DOMAIN)\(PATH_FLODER)/\(path)"
        let url = "https://api.coinranking.com/v2/coins"
        //https://api.coinranking.com/v2/coin/razxDUgYGNAdQ
        
        
        parameters = ["limit": 50]
        
        Alamofire.request("\(HTTP)://\(DOMAIN)\(PATH_FLODER)/\(path)", method: .get, parameters: parameters).validate(contentType: ["application/json"])
            .validate()
            .responseJSON { response in
                switch response.result{
                case .success (let data):
                    let json = JSON(data)
                    //print("som: JSON: \(json)")
                    
                    //print("som: decode status: \(json["status"].stringValue)")
                    // check response code
                    switch json["status"].stringValue {
                    case "success":
                        let data = json["data"]["coins"]
                        if data.exists() {
                            //print("som: have json[data][coins]")
                            completionHandler?(data)
                        } else {
                            //print("som: no data in returned JSON")
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
                    print("som: Error: \(error)")
                    break
                }
        }
        
//        Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default)
//            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
//                print("som: Progress: \(progress.fractionCompleted)")
//            }
//            .validate { request, response, data in
//                print("Som: ss: request", request)
//                print("Som: ss: res", response)
//                print("Som: ss: data", data)
//                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
//                return .success
//            }
//            .responseJSON { response in
//                print("som: \(response)")
//                debugPrint(response)
//            }
        
//        Alamofire.req
//        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
//            .validate()
//            //show log
////            .responseString { response in
////                self.showResponseLog(response)
////            }
//            //show log END.
//            .responseJSON { response in
//                print("-response json- ", response)
//                switch response.result {
//                case .success(let value):
//                    let json = JSON(value)
//                    print("JSON: \(json)")
//
//                    switch json["status"].stringValue {
//                    case "success":
//                        let data = json["data"]
//                        if data.exists() {
//                            completionHandler?(data)
//                        } else {
//                            print("no data in returned JSON")
//                            completionHandler?(JSON.null)
//                        }
//                    default: //"fail" or other
//                        let status = json["status"].stringValue
//                        let type = json["type"].stringValue
//                        let message = json["message"].stringValue
//                        print("\(type):\(message)")
//                        errorHandler?(status, message)
//                    }
//                case .failure(let error):
//                    print("Can't convert to JSON or error : \(error)")
//                    errorHandler?(nil,nil)
//                }//swift
//            }
        //

    }
    
//    static func showResponseLog(_ response: DataResponse<String> ) {
//        print("-----Request-----")
//        print(response.request!)  // original URL request
//        for (key, value) in response.request?.allHTTPHeaderFields ?? [:] {
//            print(key+" = "+value )
//        }
//        if let requestBody = response.request?.httpBody {
//            print("Body = "+String(data: requestBody, encoding: String.Encoding.utf8)!)
//        }
//        print("-----Response-----")
//        switch response.result {
//        case .success(let value):
//            print(response.response!) // URL response
//            print("Success: \(response.result.isSuccess)")
//            print("-----Response String-----")
//            print(value)
//        case .failure(let error):
//            print("Error: \(error)")
//        }
//    }
    
}
