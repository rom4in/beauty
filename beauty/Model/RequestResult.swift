//
//  CuratedResult.swift
//  beauty
//
//  Created by Ubicolor on 07/12/2021.
//

import Foundation

extension PexelsAPI {
    
    struct RequestResult: Decodable {
        var photos: [Photo]?
    }
}
