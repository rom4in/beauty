//
//  ContentView.swift
//  beauty
//
//  Created by Ubicolor on 07/12/2021.
//

import SwiftUI

struct RouterView: View {
    var body: some View {
        
        TabView {
            CuratedView()
                .tabItem {
                    Image(systemName: "rectangle.stack")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RouterView()
    }
}
