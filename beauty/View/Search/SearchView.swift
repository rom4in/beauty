//
//  SearchView.swift
//  beauty
//
//  Created by Ubicolor on 07/12/2021.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var model = SearchView.ViewModel.shared
    
    var body: some View {
        NavigationView {
            ScrollView {
                if model.photos.isEmpty {
                    Image(systemName: "magnifyingglass")
                        .font(.largeTitle)
                        .opacity(0.5)
                        .frame(height: 400)
                        .contentShape(Rectangle())
                } else {
                    
                    LazyVStack {
                        ForEach(model.photos) { photo in
                            
                            GeometryReader { geometry in
                                
                                PhotoView(photo: photo)
                                    .rotation3DEffect(
                                        Angle(degrees: (geometry.frame(in: .global).minY) - 100) / 20,
                                        axis: (x: -1, y: -1, z: -1))
                            }
                            .frame(width: UIScreen.main.bounds.width - 20)
                            .aspectRatio(photo.ratio, contentMode: .fit)
                        }
                    }
                    
                }
            }.navigationTitle("Search")
        }
        
        .searchable(text: $model.searchTerm, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
        
        .onSubmit(of: .search) {
            model.fetchSearchPhotos()
        }
    }
}



struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
