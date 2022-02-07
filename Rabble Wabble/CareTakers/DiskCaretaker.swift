//
//  DiskCaretaker.swift
//  Rabble Wabble
//
//  Created by Ahmed Amin on 05/02/2022.
//

import Foundation



final class DiskCaretaker {
    
    static let encoder = JSONEncoder()
    static let decoder = JSONDecoder()
    
    static func save<T: Codable>(_ object: T, to fileName: String) throws {
        do {
            let url = createDocumentURL(withFileName: fileName)
            let data = try encoder.encode(object)
            try data.write(to: url, options: .atomic)
        } catch(let error) {
            print("Save failed: Object: `\(object)`, " +
                  "Error: `\(error)`")
            throw error
        }
    }
    
    
    static func retrieve<T: Codable>(_ type: T.Type, from fileName: String) throws -> T {
        do {
            let url = createDocumentURL(withFileName: fileName)
            return try retrieve(T.self, from: url)
        }
    }
    
    static func retrieve<T: Codable>(_ type: T.Type, from url: URL) throws -> T {
        do {
            let data = try Data(contentsOf: url)
            return try decoder.decode(T.self, from: data)
        } catch (let error) {
            print("Retrieve failed URL: \(url)")
            throw error
        }
    }
    
    static func createDocumentURL(withFileName fileName: String) -> URL {
        let fileManager = FileManager.default
        let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return url.appendingPathComponent(fileName).appendingPathExtension("json")
    }
    
}
