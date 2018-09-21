//
//  DataFetcher.swift
//  Tsetatonsisith
//
//  Created by Abdul Sami on 20/09/2018.
//  Copyright © 2018 Abdul Sami. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit

internal class DataFetcher {
    
    private let cache:Cache
    
    public init(cache:Cache) {
        self.cache = cache
    }
    
    //DataRequest->Decodable
    internal func run<T:Decodable> (_ request:DataRequest, base64Encoded:Bool=false, onSuccess: @escaping (T)->(), onFailure: @escaping ErrorCall) {

        self.run(request, base64Encoded:base64Encoded, onSuccess: { (data:Data) in
            do {
                let decodable = try JSONDecoder().decode(T.self, from: data)
                onSuccess(decodable)
            }
            catch { (error)
                #if DEBUG
                let string = String(data: data, encoding: String.Encoding.utf8) ?? "No decodable response received"
                print("❗️Request: \(request.url)")
                print("❗️Response: \(string)")
                print("❗️Decoding Error Occurred!" )
                print(error)
                #endif
                URLCache.shared.removeCachedResponse(for: request.urlRequest!)
                return onFailure(error)
            }

        }, onFailure: onFailure)
    }
    
    //DataRequest->RawData
    internal func run(_ request:DataRequest, base64Encoded:Bool=false, onSuccess: @escaping (Data)->(), onFailure: @escaping ErrorCall) {

        Alamofire.request(request).responseData { (response) in

            guard let httpResponse = response.response else {
                if let error = response.result.error ?? response.error {
                    if self.cache.isCached(request: request) {
                        if let urlRequest = try? request.asURLRequest() {
                            guard let response = self.cache.cachedResponse(for: urlRequest) else {
                                return
                            }
                            return onSuccess(response.data)
                        }
                    }
                    return onFailure(error)
                }
                return onFailure(nil)
            }
            
            let dataResponse = DataResponse(statusCode: httpResponse.statusCode, headers: httpResponse.allHeaderFields)
            request.response = dataResponse
            
            //Process caching headers
            if let request = request.urlRequest {
                self.cache.process(urlResponse: httpResponse, urlRequest: request)
            }
            
             //Success
            if let data = response.data, let request = request.urlRequest {
                self.cache.process(urlResponse: httpResponse, urlRequest: request)
                self.cache.storeCachedResponse(CachedURLResponse(response: httpResponse, data: data), for: request)
                return onSuccess(data)
            }
        }
    }
}
