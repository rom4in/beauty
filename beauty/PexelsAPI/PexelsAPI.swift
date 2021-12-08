//
//  AppDataService.swift
//  beauty
//
//  Created by Ubicolor on 07/12/2021.
//

import Foundation
import Combine

class PexelsAPI {
    
    static let shared = PexelsAPI()
    private var cancellable: AnyCancellable?
    private static let beautyQueue = DispatchQueue(label: "hire.me.beauty.queue")


    func fetchCurated(completion: @escaping (Array<Photo>) -> Void) {
        var components: URLComponents = URLComponents(string: PexelsAPI.APIUrls.curated)!
        let queryItems = [URLQueryItem(name: "per_page", value: "80")]
        components.queryItems = queryItems
        guard let url = components.url else { return }
        var request = URLRequest(url: url)
        request.setValue(PexelsAPI.APIKeys.privateKey, forHTTPHeaderField: PexelsAPI.APIKeys.header)
        cancellable = URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: Self.beautyQueue)
            .map({ return $0.data })
            .decode(type: CuratedResult.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { receiveCompletion in
                switch receiveCompletion {
                case .finished: break
                case .failure: break //TODO: investigate why
                    
                }
            }, receiveValue: { curation in
                
                completion(curation.photos ?? [])
                print(curation.photos?.count ?? "no photos")
                
        })
        
    }
        
}
