//
//  APIService.swift
//  CheckList
//
//  Created by Sumona Salma on 4/14/19.
//  Copyright © 2019 Sumona Salma. All rights reserved.
//

import Foundation

class Service: NSObject {
    static let shared = Service()
    
    func getData(urlString:String, completion: @escaping (WikiData?, Error?) -> ()) {
       print(urlString)
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                print("Failed to fetch data:", err)
                return
            }
            guard let data = data else { return }
            do {
                let results = try JSONDecoder().decode(WikiData.self, from: data)
                DispatchQueue.main.async {
                    completion(results, nil)
                }
            } catch let err {
                LoadingOverlay.shared.hideOverlayView()
                print("Failed to decode:", err)
                //completion(nil, err)
            }
        }.resume()
    }
}
