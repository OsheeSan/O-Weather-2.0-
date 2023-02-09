//
//  LocationManager.swift
//  O-Weather
//
//  Created by admin on 07.02.2023.
//

import Foundation
import CoreLocation

struct Location{
    let city: String?
    let coordinates: CLLocationCoordinate2D?
    let rows: Int
    let country: String?
    let adminRegion: String?
    let subAdminRegion: String?
    let index: String?
}

class LocationManager: NSObject{
    static let shared = LocationManager()
    let manager = CLLocationManager()
    
    public func findLocations(with query: String, completion: @escaping(([Location]) -> Void)){
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(query){ places, error in
            guard let places = places, error == nil else {
                completion([])
                return
            }
            let models: [Location] = places.compactMap({ place in
                var name = ""
                var row = 1
                if let locationName = place.name {
                    name += locationName
                    row += 1
                }
                if let country = place.country {
                    name += ", \(country)"
                    row += 1
                }
                if let adminRegion = place.administrativeArea {
                    name += ", \(adminRegion)"
                    row += 1
                }
                if let subAdminRegion = place.subAdministrativeArea {
                    name += ", \(subAdminRegion)"
                    row += 1
                }
                if let index = place.postalCode {
                    name += ", \(index)"
                    row += 1
                }
                let result = Location(city: place.name,
                                      coordinates: place.location?.coordinate,
                                      rows: row,
                                      country: place.country,
                                      adminRegion: place.administrativeArea,
                                      subAdminRegion: place.subAdministrativeArea,
                                      index: place.postalCode)
                return result
            })
            completion(models)
        }
    }
}
 
