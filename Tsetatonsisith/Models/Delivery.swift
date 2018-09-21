//
//  Delivery.swift
//  Tsetatonsisith
//
//  Created by Abdul Sami on 20/09/2018.
//  Copyright © 2018 Abdul Sami. All rights reserved.
//

import Foundation

public class Delivery: Decodable {
    
    public var id: Int?
    public var description: String?
    public var imageUrl: String?
    public var location: Location?
    
    private enum CodingKeys: String, CodingKey {
        case id, description, imageUrl, location
    }
    
    public init() {
        id = 0
        description = ""
        imageUrl = ""
        location = Location()
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        description = try container.decode(String.self, forKey: .description)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
        location = try container.decode(Location.self, forKey: .location)
    }
}
