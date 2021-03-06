//
//  ContentView.swift
//  Covid Test Finder
//
//  Created by Jody Clelland on 3/3/21.
//

import SwiftUI
import MapKit

struct SplashScreenView: View {
    
    @State var animate = false
    @State var endSplash = false
    
    var body: some View {
        ZStack {
            Color("SplashScreenBackground")
            
            Image("Logo")
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .frame(width: animate ? nil : 45, height: animate ? nil: 45)
                .scaleEffect(animate ? 3 : 1)
                .frame(width: UIScreen.main.bounds.width)
        }
        
        .ignoresSafeArea(.all, edges: .all)
        .onAppear(perform: animateSplash)
        .opacity(endSplash ? 0 : 1)
        
        
    }
    
    func animateSplash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(Animation.easeOut(duration: 1.0)) {
                animate.toggle()
            }
        }
        
    }
}
       
            
            
   

struct ContentView: View {
    
    @ObservedObject var locationManager = LocationManager()
    @State private var landmarks: [Landmark] = [Landmark]()
    @State private var search: String = ""
    
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
    
    var body: some View {
        ZStack(alignment: .top) {
            
            MapView(landmarks: landmarks).ignoresSafeArea()
            
            TextField("Search for Test Centre", text: $search, onEditingChanged: { _ in })
            {
                self.getNearbyLandmarks()
            }.textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .offset(y: 44)
               
    }
        }

}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView()
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
