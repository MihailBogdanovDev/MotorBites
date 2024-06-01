import Alamofire
import CoreLocation

struct Place: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

class PlacesAPI {
    static func fetchNearbyPlaces(for types: [IngredientType], location: CLLocationCoordinate2D, completion: @escaping ([Place]) -> Void) {
            var allPlaces = [Place]()
            let group = DispatchGroup()
            
            for type in types {
                group.enter()
                let storeType = mapIngredientTypeToStoreType(type)
                let apiKey = "AIzaSyAvLFqqNO2N6-dPQef4EntH7gZHsFdNbi0"
                let url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
                let parameters: [String: Any] = [
                    "location": "\(location.latitude),\(location.longitude)",
                    "radius": "5000",
                    "type": "store",
                    "keyword": storeType,
                    "key": apiKey
                ]

                AF.request(url, method: .get, parameters: parameters).responseJSON { response in
                    defer { group.leave() }
                    guard let data = response.data else {
                        print("No data received: \(response.error?.localizedDescription ?? "Unknown error")")
                        return }
                    print(String(data: data, encoding: .utf8) ?? "Could not print data") // Print raw JSON for inspection
                    do {
                        let jsonData = try JSONDecoder().decode(GooglePlacesResponse.self, from: data)
                        let places = jsonData.results.map {
                            Place(name: $0.name, coordinate: CLLocationCoordinate2D(latitude: $0.geometry.location.lat, longitude: $0.geometry.location.lng))
                        }
                        allPlaces.append(contentsOf: places)
                    } catch {
                        print("Decoding error: \(error)")
                    }
                }
            }

            group.notify(queue: .main) {
                completion(allPlaces)
            }
        }

    
    static func mapIngredientTypeToStoreType(_ type: IngredientType) -> String {
        switch type {
        case .asian:
                return "Asian grocery"
            case .middleEastern:
                return "Middle Eastern market"
            case .balkan:
                return "European market"
            case .hispanic:
                return "Latin American grocery"
            case .italian:
                return "Italian grocery"
            case .african:
                return "African market"
            case .organic:
                return "Organic food store"
            case .herbsAndSpices:
                return "Spice shop"
            case .seafood:
                return "Fish market"
            case .meat:
                return "Butcher shop"
            case .healthFoods:
                return "Health food store"
            case .scottish:
                return "Scottish market"
            case .generic:
                return "Supermarket"
        default:
            return "Supermarket"
        }
    }
}

struct GooglePlacesResponse: Decodable {
    let results: [Result]
}

struct Result: Decodable {
    let name: String
    let geometry: Geometry
}

struct Geometry: Decodable {
    let location: Location
}

struct Location: Decodable {
    let lat: Double
    let lng: Double
}
