//
//  CuratedView+ViewModel.swift
//  beauty
//
//  Created by Ubicolor on 08/12/2021.
//

import Foundation

extension CuratedView {
    class ViewModel: ObservableObject {
        
        static let shared: ViewModel = .init()

        @Published var photos = [Photo]()
        
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
