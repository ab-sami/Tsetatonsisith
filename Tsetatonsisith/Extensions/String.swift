//
//  String.swift
//  Tsetatonsisith
//
//  Created by Abdul Sami on 20/09/2018.
//  Copyright © 2018 Abdul Sami. All rights reserved.
//

import Foundation


extension String {
    public func escape()->String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
    
    public func concat(urlPath:String)->String {
        return self + (self.hasSuffix("/") ? "" : "/") +  urlPath
    }
}
