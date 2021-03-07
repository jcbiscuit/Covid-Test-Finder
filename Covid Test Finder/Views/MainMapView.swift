//
//  MainMapView.swift
//  Covid Test Finder
//
//  Created by Jody Clelland on 7/3/21.
//

import SwiftUI
import MapKit

struct MainMapView: View {
    
    @ObservedObject var locationManager = LocationManager()
    @State private var landmarks: [Landmark] = [Landmark]()
    @State private var search: String = ""
    @State private var tapped: Bool = false
    
    private func getNearbyLandmarks() {
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = search
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if let response = response {
                let mapItems = response.mapItems
                self.landmarks = mapItems.map {
                    Landmark(placemark: $0.placemark)
                }
            }
        }
    }
    
    func calculateOffset() -> CGFloat {
        if self.landmarks.count > 0 && !self.tapped {
            return UIScreen.main.bounds.size.height / 6
        }
        else if self.tapped {
            return 650
        } else {
            return UIScreen.main.bounds.size.height
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            
            MapView(landmarks: landmarks).ignoresSafeArea()
            
            TextField("Search for Test Centre", text: $search, onEditingChanged: { _ in })
            {
                self.getNearbyLandmarks()
            }.textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .offset(y: 44)
            
            
            PlaceListView(landmarks: self.landmarks) {
                self.tapped.toggle()
            }.animation(.spring())
            .offset(y: calculateOffset())
    }
        }

}
struct MainMapView_Previews: PreviewProvider {
    static var previews: some View {
        MainMapView()
        MainMapView()
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

