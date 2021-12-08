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
                                    axis: (x: 1, y: 1, z: 1))

                        }
                        .frame(width: UIScreen.main.bounds.width - 20)
                        .aspectRatio(photo.ratio, contentMode: .fit)
                    }
                }
            }
        }
    }
}
