//
//  NetworkServise.swift
//  Navigation
//
//  Created by Aleksey on 29.12.2022.
//

import Foundation

enum AppConfiguration : String, CaseIterable {
    
    case people = "https://swapi.dev/api/people/8"
    case starships = "https://swapi.dev/api/starships/3"
    case planets = "https://swapi.dev/api/planets/5"
    
}

struct NetworkService {
    
    static func request(for configuration: AppConfiguration) {
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        
        if let url = URL(string: configuration.rawValue) {
            let task = urlSession.dataTask(with: url, completionHandler: { data, responce, error in
                
                if let parsedData = data {
                    print("Data \((String(data: parsedData, encoding: .utf8)) ?? "")")
                }
                
                if let responce = responce as? HTTPURLResponse {
                    print("Responce")
                    print("AllHeaderFields: \(responce.allHeaderFields)")
                    print("StatusCode: \(responce.statusCode)")
                }
                
                print("Error: \(String(describing: error))")
                print(error?.localizedDescription as Any)
            })
            
            task.resume()
        }
    }
}
