import CoreLocation

struct CustomLocation: Equatable {
    let coordinate: CLLocationCoordinate2D
}

func ==(lhs: CustomLocation, rhs: CustomLocation) -> Bool {
    return lhs.coordinate.latitude == rhs.coordinate.latitude && lhs.coordinate.longitude == rhs.coordinate.longitude
}

