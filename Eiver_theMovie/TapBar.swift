//
//  TapBar.swift
//  The_Movie
//
//  Created by walid dadi on 07/06/2021.
//

import SwiftUI

struct TapBar: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            
            splash_screen(selectedTab: $selectedTab).tabItem {
                Image(systemName: "rectangle.stack.fill")
                Text("Splash Screen")
            }
            .tag(0)

            Film_view().tabItem {
                Image(systemName: "rectangle.stack.fill")
                Text("Films")
            }
            .tag(1)
            
        }
    }
}

struct TapBar_Previews: PreviewProvider {
    static var previews: some View {
        TapBar()
    }
}
