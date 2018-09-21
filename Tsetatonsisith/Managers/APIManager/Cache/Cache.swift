//
//  Cache.swift
//  Tsetatonsisith
//
//  Created by Abdul Sami on 20/09/2018.
//  Copyright © 2018 Abdul Sami. All rights reserved.
//

import Foundation


public class Cache : URLCache {
    private let CacheTimeStampKey = "CacheTimestamp"
    private let cacheDuration:TimeInterval
    
    public init(clearCache: Bool = false, memoryCapacityInMB: Int = 50, diskCapacityInMB: Int = 100, cacheDurationInSeconds:Int = 4 * 60 * 60) {
        cacheDuration = TimeInterval(cacheDurationInSeconds)
        super.init(memoryCapacity: memoryCapacityInMB * 1024 * 1024, diskCapacity: diskCapacityInMB * 1024 * 1024, diskPath: "starzUrlCache")
        if clearCache {
            removeAllCachedResponses()
        }
        URLCache.shared = self
    }
    
    public override func removeAllCachedResponses() {
        super.removeAllCachedResponses()
    }
    
    public func removeCached(request:DataRequest) {
        if let urlRequest = try? request.asURLRequest() {
            self.removeCachedResponse(for: urlRequest)
        }
    }
    
    public func process(urlResponse:HTTPURLResponse, urlRequest:URLRequest) {
        guard let cache = urlResponse.allHeaderFields["Cache-Control"] as? String else {
            return
        }
        
        if cache.contains("must-revalidate") || cache.contains("no-store") || cache.contains("no-cache") {
            self.removeCachedResponse(for: urlRequest)
        }
    }
    
    public func isCached(request:DataRequest)->Bool {
        if let urlRequest = try? request.asURLRequest() {
            return self.cachedResponse(for: urlRequest) != nil
        }
        return false
    }
    
    public override func cachedResponse(for request: URLRequest) -> CachedURLResponse? {
        guard let cachedResponse = super.cachedResponse(for: request) else { return nil }
        guard let userInfo = cachedResponse.userInfo else { return cachedResponse }
        guard let timestamp = userInfo[CacheTimeStampKey] as? Date else { return cachedResponse }
        
        if abs(timestamp.timeIntervalSinceNow) < cacheDuration {
            return cachedResponse
        }
        
        self.removeCachedResponse(for: request)
        return nil
        
    }
    
    public override func storeCachedResponse(_ cachedResponse: CachedURLResponse, for request: URLRequest) {
        var userInfo:[AnyHashable : Any] = cachedResponse.userInfo ?? [:]
        userInfo[CacheTimeStampKey] = Date()
        
        let newCachedResponse = CachedURLResponse(response: cachedResponse.response, data: cachedResponse.data, userInfo: userInfo, storagePolicy: cachedResponse.storagePolicy)
        super.storeCachedResponse(newCachedResponse, for: request)
    }
}
