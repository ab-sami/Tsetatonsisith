//
//  DeliveryManager.swift
//  Tsetatonsisith
//
//  Created by Abdul Sami on 20/09/2018.
//  Copyright © 2018 Abdul Sami. All rights reserved.
//

import Foundation


public class DeliveryManager {
    
    private let cache = Cache()
    internal let fetcher:DataFetcher
    private let service:ApiService
    
    internal init() {
        self.fetcher = DataFetcher(cache: cache)
        self.service = ApiService()
    }
    
    func getDeliveriesListBy(offset: Int,
                            onSuccess: @escaping DeliveryListCall,
                            onFailure: @escaping ErrorCall) {
        
        let request = service.getDeliveriesByOffset(offset: 15, forceNetwork: true)
        
        fetcher.run(request, onSuccess: {(deliveryList: [Delivery]) in
            onSuccess(deliveryList)
        }, onFailure: { (error) in
            onFailure(error)
        })
    }
}
