//
//  DeliveryDetailsViewController.swift
//  Tsetatonsisith
//
//  Created by Abdul Sami on 20/09/2018.
//  Copyright © 2018 Abdul Sami. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DeliveryDetailsViewController: UIViewController {

    let regionRadius: CLLocationDistance = 1000
    
    var mapView: MKMapView?
    var delivery: Delivery?
    
    static func create(delivery: Delivery) -> DeliveryDetailsViewController {
        let vc = DeliveryDetailsViewController(delivery: delivery)
        return vc
    }
    
    //MARK:- Intitialization
    
    public init(delivery: Delivery) {
        self.delivery = delivery
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView = MKMapView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        mapView?.showsUserLocation = true
        view.addSubview(mapView!)
        setUpView()
        centerMapOnLocation()
    }
    
    private func setUpView() {
        navigationItem.title = "Delivery Details"
    }
    
    func centerMapOnLocation() {
        
        guard let location = self.delivery?.location else {
            return
        }
        let currentLocation = CLLocation(latitude: location.lat ?? 10.0, longitude: location.lng ?? -10.0)

        let coordinateRegion = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, regionRadius, regionRadius)
        self.mapView?.setRegion(coordinateRegion, animated: true)
        
        addAnnotation()
    }
    
    func addAnnotation() {
        
        guard let delivery = delivery, let location = self.delivery?.location else {
            return
        }
        
        let artwork = Artwork(title: delivery.description ?? "",
                              locationName: location.address ?? "",
                              coordinate: CLLocationCoordinate2D(latitude: location.lat ?? 10.0, longitude: location.lng ?? -10.0))
        mapView?.addAnnotation(artwork)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
