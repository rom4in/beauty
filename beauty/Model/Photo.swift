//
//  Photo.swift
//  beauty
//
//  Created by Ubicolor on 07/12/2021.
//

import UIKit

struct Photo: Identifiable, Decodable, Equatable {
    
    public var id: Int
    public var url: String
    public var width: Int
    public var height: Int
    public var src: Dictionary<Size.RawValue,String>
    public var averageColor: String { return avg_color }
    public var photographer: String
    
    private var photographer_url: String
    private var photographer_id: Int
    private var avg_color: String
    
    enum Size: String {
        case original, large2x, large, medium, small, portrait, landscape, tiny
    }
    
    public var ratio : Double {
        Double(width)/Double(height)
    }

}
