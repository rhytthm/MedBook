//
//  Countries.swift
//  MedBook
//
//  Created by Rhytthm Mahajan on 13/08/23.
//

import Foundation

// MARK: - Countries
struct Countries: Codable {
   
    let data: [String: Country]
    
    static let allCountries: Countries = Bundle.main.decode(file: "Countries.json")
    
}

// MARK: - Country
struct Country: Codable, Hashable{
    let country: String
}

extension Bundle {
    func decode<T: Decodable>(file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode \(file) from bundle.")
        }
        
        return loadedData
    }
}
