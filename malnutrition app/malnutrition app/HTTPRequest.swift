//
//  HTTPRequest.swift
//  jumpmaniOS
//
//  Created by Bowen Jin on 2/14/17.
//  Copyright © 2017 Bowen Jin. All rights reserved.
//
import Foundation
import SwiftyJSON
import SystemConfiguration


class HTTPRequest{
    var url:String;
    var postString: String
    var method: String;
    
    init(url: String, method: String, parameters: Dictionary<String, String>){
        self.url = url;
        var string = "";
        for (key, value) in parameters{
            if(string != ""){
                string += "&"
            }
            string += (key + "=" + value);
        }
        postString = string;
        self.method = method;
        
    }
    
    func send(callback: @escaping (Any)->(), errorHandler: @escaping (String)->()){
        if(!isInternetAvailable()){
            errorHandler(NSLocalizedString("No internet connection", comment: ""));
            return;
        }
        var request = URLRequest(url: URL(string: self.url)!)
        request.httpMethod = self.method
        //        let postString = "id=13&name=Jack"
        if(self.method == "POST"){
            request.httpBody = postString.data(using: .utf8)
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 DataStore.get().errorHandler(error: String(describing: error));
                return;
            }
            let contentType = (response as! HTTPURLResponse).allHeaderFields["Content-Type"] as? String
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                let error = "statusCode should be 200, but is \(httpStatus.statusCode)"
                errorHandler("An error ocurred");
                print(error)
                print("response = \(response)")
            }
            else{
                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(responseString)")
                if let dataFromString = responseString?.data(using: .utf8, allowLossyConversion: false) {
                    print("Response Content-Type = " + contentType!);
                    if(contentType?.contains("application/json"))!{
                        let json = JSON(data: dataFromString);
                        if json["error"].string == nil{
                            var response = Dictionary<String, String>();
                            for (key, value) in json["data"]{
                                response[key] = value.string!
                            }
                            callback(response)
                        }
                        else{
                            errorHandler(json["error"].string!);
                        }
                    }
                    else if(contentType == "application/x-apple-aspen-config"){
                        callback(data);
                    }
                    else{
                        errorHandler("Response Content-Type not recognized");
                    }
                }
                else{
                    errorHandler("invalid json string");
                }
            }
            
            
        }
        task.resume()
    }
    
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
}
