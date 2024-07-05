import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var locationManager: LocationManager
    var ingredient: Ingredient
    @State private var region = MKCoordinateRegion()
    @State private var places: [Place] = []
    @State private var userHasMovedMap = false  // New state to track user interaction

    var body: some View {
        Text(ingredient.name)
        Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: places) { place in
            MapMarker(coordinate: place.coordinate, tint: .blue)
        }
        .onAppear {
            if let location = locationManager.currentLocation?.coordinate {
                           updateRegion(to: location)
                           loadPlaces(for: ingredient, location: location)
                            print("in start")
                            print(places)
                       }
        }
        .onChange(of: locationManager.currentLocation) { newLocation in
            if let location = newLocation?.coordinate, !userHasMovedMap {
                updateRegion(to: location)
                loadPlaces(for: ingredient, location: location)
                print("in update")
                print(places)
            }
        }
        .gesture(DragGesture().onChanged({ _ in
                  self.userHasMovedMap = true  // User has interacted, stop auto-centering
              }))
    }

    private func updateRegion(to location: CLLocationCoordinate2D?) {
        guard let location = location else { return }
        region = MKCoordinateRegion(
            center: location,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    }

    private func loadPlaces(for ingredient: Ingredient, location: CLLocationCoordinate2D?) {
        guard let location = location else { return }
        PlacesAPI.fetchNearbyPlaces(for: ingredient.types, location: location) { newPlaces in
            self.places = newPlaces
        }
    }
}
