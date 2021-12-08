//
//  CuratedView.swift
//  beauty
//
//  Created by Ubicolor on 07/12/2021.
//

import SwiftUI

struct CuratedView: View {
    
    @StateObject private var model = ViewModel.shared
    
    var body: some View {
        
        if model.photos.isEmpty {
            
            ZStack {
                Color.clear
                ProgressView()
            }
            
        } else {
            ScrollView {
                LazyVStack {
                    ForEach(model.photos) { photo in
                        
                        GeometryReader { geometry in
                            
                            PhotoView(photo: photo)
                                .rotation3DEffect(
                                    Angle(degrees: (geometry.frame(in: .global).minY) - 100) / 20,
                                          axis: (x: 10, y: 50, z: 10))
                            
                        }
                        .frame(width: UIScreen.main.bounds.width - 20)
                        .aspectRatio(photo.ratio, contentMode: .fit)
                    }
                }
            }
        }
    }
}

extension CuratedView {
    class ViewModel: ObservableObject {
        @Published var photos = [Photo]()
        static let shared: ViewModel = .init()
        
        init() {
            fetchCuratedPhotos()
        }
        
        func fetchCuratedPhotos() {
            PexelsAPI.shared.fetchCurated() { results in
                self.photos = results
            }
        }
    }
}

struct CuratedView_Previews: PreviewProvider {
    static var previews: some View {
        CuratedView()
    }
}
