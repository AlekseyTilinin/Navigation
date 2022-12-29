//
//  NetworkServise.swift
//  Navigation
//
//  Created by Aleksey on 29.12.2022.
//

import Foundation

enum AppConfiguration : String, CaseIterable {
    
    case first = "https://jsonplaceholder.typicode.com/todos/1"
    case second = "https://jsonplaceholder.typicode.com/todos/2"
    case third = "https://jsonplaceholder.typicode.com/todos/3"
    case fourth = "https://jsonplaceholder.typicode.com/todos/4"
    case fifth = "https://jsonplaceholder.typicode.com/todos/5"
    case fourteenth = "https://jsonplaceholder.typicode.com/todos/14"
}

struct InfoTitle {
    
    var title: String = ""
}

var infoTitle = InfoTitle()

struct NetworkService {
    
    static func request(for configuration: AppConfiguration) {
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        
        if let url = URL(string: configuration.rawValue) {
            let task = urlSession.dataTask(with: url, completionHandler: { data, responce, error in
                
                if let parsedData = data {
                    let str = String(data: parsedData, encoding: .utf8)
                    
                    if let stringToSerilization = str {
                        let dataToSerilization = Data(stringToSerilization.utf8)
                        
                        do {
                            
                            if let json = try JSONSerialization.jsonObject(with: dataToSerilization, options: []) as? [String: Any] {
                                if let title = json["title"] as? String {
                                    infoTitle.title = title
                                }
                            }
                        } catch let error as NSError {
                            print("Error: \(error)")
                        }
                    }
                }
            })
            
            task.resume()
        }
    }
}
