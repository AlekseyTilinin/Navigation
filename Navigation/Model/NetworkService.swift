//
//  NetworkServise.swift
//  Navigation
//
//  Created by Aleksey on 29.12.2022.
//

import Foundation

enum AppConfiguration : String {
    
    case title = "https://jsonplaceholder.typicode.com/todos/1"
    case planets = "https://swapi.dev/api/planets/1"
}

struct UserData: Codable {
    
    var userId: Int
    var id: Int
    var title: String
    var complited: Bool
}

struct PlanetData: Codable {
    var name: String
    var rotationPeriod: String
    var orbitalPeriod: String
    var diameter: String
    var climate: String
    var gravity: String
    var terrain: String
    var surfaceWater: String
    var population: String
    var residents: [String]
    var films: [String]
    var created: String
    var edited: String
    var url: String
}

var infoTitle: String = ""

var planetOrbitalPeriod: String = ""
var planetName: String = ""

var residents: [String] = []

struct NetworkService {
    
    static func request(for configuration: AppConfiguration) {
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        
        if let url = URL(string: configuration.rawValue) {
            let task = urlSession.dataTask(with: url, completionHandler: { data, responce, error in
                
                if let parsedData = data {
                    switch configuration {
                    case .title:
                        let str = String(data: parsedData, encoding: .utf8)
                        
                        if let stringToSerilization = str {
                            let dataToSerilization = Data(stringToSerilization.utf8)
                            
                            do {
                                if let json = try JSONSerialization.jsonObject(with: dataToSerilization, options: []) as? [String: Any] {
                                    if let title = json["title"] as? String {
                                        infoTitle = title
                                    }
                                }
                            } catch let error as NSError {
                                print("Error: \(error)")
                            }
                        }
                        
                    case .planets:
                        
                        do {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let planet = try decoder.decode(PlanetData.self, from: parsedData)
                            planetOrbitalPeriod = planet.orbitalPeriod
                            planetName = planet.name
                            residents = planet.residents
                        }
                        catch let error {
                            print(error)
                        }
                    }
                }
            })
            
            task.resume()
        }
    }
    
    static func request(for configuration: String, index: Int) {
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        
        if let url = URL(string: configuration) {
            let task = urlSession.dataTask(with: url, completionHandler: { data, responce, error in
                
                if let parsedData = data {
                    let str = String(data: parsedData, encoding: .utf8)
                    
                    if let stringToSerilization = str {
                        let dataToSerilization = Data(stringToSerilization.utf8)
                        
                        do {
                            if let json = try JSONSerialization.jsonObject(with: dataToSerilization, options: [] ) as? [String: Any] {
                                if let name = json["name"] as? String {
                                    residents[index] = name
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
