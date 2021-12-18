//
//  JsonVIewModel.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/11/23.
//

import Foundation

class JsonViewModel: ObservableObject {
    
    init() {
        
    }
    
    func dictionaryToJson() -> String {
        var someDictionary: [String: Any] = Dictionary()
        someDictionary["text"] = "hello"
        someDictionary["value"] = 10.0
        
        do {
            let someJson = try JSONSerialization.data(withJSONObject: someDictionary, options: .prettyPrinted)
            let someData = String(data: someJson, encoding: .utf8)
            return someData ?? "Data enconding to string fail."
        } catch {
            return error.localizedDescription
        }
    }
    
    func stringDictionaryToJsonObject() -> String {
        let someString = "{\"text\": \"hello\", \"value\": 10.0}"
        
        guard let data = someString.data(using: .utf8) else {
            return "String encoding to data fail."
        }
        
        do {
            let object = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            return object?.description ?? "JSONSerialization failed."
        } catch {
            return error.localizedDescription
        }
    }
    
    func stringArrayToJsonObject() -> String {
        let someString = "{\"texts\": [\"hello\", \"world\", \"again\"]}"
        let data = Data(someString.utf8)
        
        do {
            let object = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            return object?.description ?? "JSONSerialization failed."
        } catch let error as NSError {
            return error.localizedDescription
        }
    }
}
