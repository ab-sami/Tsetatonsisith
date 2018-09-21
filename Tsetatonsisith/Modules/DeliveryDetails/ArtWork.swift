//
//  ArtWork.swift
//  Tsetatonsisith
//
//  Created by Abdul Sami on 21/09/2018.
//  Copyright © 2018 Abdul Sami. All rights reserved.
//


import MapKit

class Artwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
