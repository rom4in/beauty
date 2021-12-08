//
//  SearchView+ViewModel.swift
//  beauty
//
//  Created by Ubicolor on 08/12/2021.
//

import Foundation

extension SearchView {
    class ViewModel: ObservableObject {
        
        static let shared: ViewModel = .init()
        @Published var searchTerm = ""

        @Published var photos = [Photo]()
        
        func fetchSearchPhotos() {
            PexelsAPI.shared.search(for: searchTerm) { results in
                self.photos = results
            }
        }
    }
}
