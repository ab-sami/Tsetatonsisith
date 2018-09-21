//
//  ApiService.swift
//  Tsetatonsisith
//
//  Created by Abdul Sami on 20/09/2018.
//  Copyright © 2018 Abdul Sami. All rights reserved.
//

import Foundation

internal class ApiService {
    private let baseUrl:String = APIConstants.kBaseUrl
    private let apiUrl:String
    
    init() {
        self.apiUrl = baseUrl.concat(urlPath: "deliveries")
    }
    
    func getDeliveriesByOffset(offset: Int, limit: Int = 20, forceNetwork: Bool) -> DataRequest {
        
        let request = DataRequest(url: apiUrl)
        request.addQueryParameter(key: "offset", value: offset.toString())
        request.addQueryParameter(key: "limit", value: limit.toString())
        request.forceNetwork = forceNetwork
        return request
    }
    
}
