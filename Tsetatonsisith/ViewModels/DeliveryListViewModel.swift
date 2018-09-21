//
//  DeliveryListViewModel.swift
//  Tsetatonsisith
//
//  Created by Abdul Sami on 20/09/2018.
//  Copyright © 2018 Abdul Sami. All rights reserved.
//

import Foundation

public class DeliveryListViewModel: BaseViewModel {
    
    private let offset = 20
    
    private var deliveryManager: DeliveryManager?
    private var deliveryList: [Delivery]?
    
    override init() {
        super.init()
        deliveryManager = DeliveryManager()
    }
    
    public override func load() {
        super.load()
        guard isReady() == false else { return }
        
        deliveryManager?.getDeliveriesListBy(offset: offset, onSuccess: { [weak self] (deliveries) in
            self?.deliveryList = deliveries
            self?.makeReady()
        }, onFailure: { [weak self] (error) in
            if let error = error {
                self?.throwError(with: error)
            }
        })
    }
    
    public func getDeliveriesCount() -> Int {
        return deliveryList?.count ?? 0
    }
    
    public func getSelectedDelivery(index: Int) -> Delivery {
        guard let delivery = deliveryList?[index] else { return Delivery() }
        return delivery
    }
 
    public func getDeliveryDescription(at index: Int) -> String {
        guard let delivery = deliveryList?[index] else { return "" }
        return delivery.description ?? ""
    }
    
    public func getDeliveryImageUrl(at index: Int) -> String {
        guard let delivery = deliveryList?[index] else { return "" }
        return delivery.imageUrl ?? ""
    }
    
    public func getDeliveryLocationAddress(at index: Int) -> String {
        guard let address = deliveryList?[index].location?.address else { return "" }
        return address
    }
    
}

