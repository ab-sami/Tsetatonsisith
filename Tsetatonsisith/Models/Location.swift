//
//  Location.swift
//  Tsetatonsisith
//
//  Created by Abdul Sami on 20/09/2018.
//  Copyright © 2018 Abdul Sami. All rights reserved.
//

import Foundation

public class Location: Decodable {
    
    public var lat: Double?
    public var lng: Double?
    public var address: String?
    
    private enum CodingKeys: String, CodingKey {
        case lat, lng, address
    }
    
    public init() {
        lat = 0.0
        lng = 0.0
        address = ""
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        lat = try container.decode(Double.self, forKey: .lat)
        lng = try container.decode(Double.self, forKey: .lng)
        address = try container.decode(String.self, forKey: .address)
    }
}



