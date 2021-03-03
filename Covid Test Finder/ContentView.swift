//
//  ContentView.swift
//  Covid Test Finder
//
//  Created by Jody Clelland on 3/3/21.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State var animate = false
    @State var endSplash = false
    
    var body: some View {
        ZStack {
            background(Color("SplashScreenBackground"))
            
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
    var body: some View {
        Text("Find Your Nearest Testing Centre")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
