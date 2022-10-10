//
//  Location.swift
//  MapApp
//
//  Created by Сергей Кривошеев on 26.08.2022.
//

import Foundation
import MapKit

struct Location: Identifiable, Equatable {
   
    var id = UUID().uuidString
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageNames: [String]
    let link: String
   
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
