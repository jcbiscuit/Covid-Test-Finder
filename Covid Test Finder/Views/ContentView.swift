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
            
            Image("MagnifyingGlass")
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .frame(width: animate ? nil : 45, height: animate ? nil: 45)
                .scaleEffect(animate ? 3 : 1)
                .frame(width: UIScreen.main.bounds.width)
       
        
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
    var body: some View {
            VStack {
                NavigationView {
                    VStack {
                Image("NewLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                   
                NavigationLink(
                    destination: MainMapView()) {
                Text("Find Nearby Test Centre")
                    .frame(width: 400, height: 70)
                    .foregroundColor(.white)
                    .background(ZStack {
                        Color("ButtonColor")
                        LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.3), Color.clear]), startPoint: .top, endPoint: .bottom)
                    })
                    .cornerRadius(50)
                    .padding(.all)
    }
                        Link("Symptom Checker", destination: URL(string: "https://www.health.gov.au/resources/apps-and-tools/healthdirect-coronavirus-covid-19-symptom-checker")!)
                            .frame(width: 400, height: 70)
                            .foregroundColor(.white)
                            .background(ZStack {
                                Color("ButtonColor")
                                LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.3), Color.clear]), startPoint: .top, endPoint: .bottom)
                            })
                                .cornerRadius(50)
                                .padding(.all)
                                
}

}
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

