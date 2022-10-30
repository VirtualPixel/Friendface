//
//  Bundle-Decodable.swift
//  Friendface
//
//  Created by Justin Wells on 10/30/22.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-y"
        decoder.dateDecodingStrategy = .iso8601
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decoed \(file) form bundle.")
        }
        
        return loaded
    }
}
