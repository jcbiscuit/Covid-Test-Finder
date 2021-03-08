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
    @StateObject private var keyboardHandler = KeyboardHandler()
    
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
            return UIScreen.main.bounds.size.height / 2
        }
        else if self.tapped {
            return 0
        } else {
            return UIScreen.main.bounds.size.height
        }
    }
    
    var body: some View {
        ZStack {
            
            MapView(landmarks: landmarks).ignoresSafeArea()
           
            TextField("Search for Test Centre", text: $search, onEditingChanged: { _ in })
            {
                self.getNearbyLandmarks()
            }.frame(width: 400, height: 45)
            .foregroundColor(.black)
            .background(Color(.white))
            .cornerRadius(10)
            .padding(.bottom, keyboardHandler.keyboardHeight)
            
//            .padding(.all)
            .padding(.top, 100)
            
           
            
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
            }
}

