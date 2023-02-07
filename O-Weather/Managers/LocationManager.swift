//
//  LocationManager.swift
//  O-Weather
//
//  Created by admin on 07.02.2023.
//

import Foundation
import CoreLocation

struct Location{
    let title: String
    let coordinates: CLLocationCoordinate2D
}

class LocationManager: NSObject{
    static let shared = LocationManager()
    let manager = CLLocationManager()
    
    public func findLocations(with query: String, completion: @escaping(([Location]) -> Void)){
        
    }
}
 
