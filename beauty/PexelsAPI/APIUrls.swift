//
//  File.swift
//  beauty
//
//  Created by Ubicolor on 07/12/2021.
//

import Foundation

extension PexelsAPI {
    
    struct APIUrls {
            static let curated: String = "https://api.pexels.com/v1/curated"
            static let search: String = "https://api.pexels.com/v1/search"
            //static let collections: String = "https://api.pexels.com/v1/collections"
        }
    
    struct APIKeys {
        static let header = "Authorization"
        static let privateKey = "563492ad6f91700001000001f3352e0665ac4e5d8ad8a7a9b8a87851"
    }
}
