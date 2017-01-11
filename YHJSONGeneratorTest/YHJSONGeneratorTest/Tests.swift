//
//  Tests.swift
//  YHJSONGeneratorTest
//
//  Created by Yilei He on 11/1/17.
//  Copyright © 2017 Yilei He. All rights reserved.
//

import UIKit
import YHJSONGenerator

class Person: NSObject {
    let name: String?
    let age: Int
    let gender: Gender
    init(name: String?, age: Int, gender: Gender = .male("M", 90)) {
        self.name = name
        self.age = age
        self.gender = gender
    }
}

struct Contact {
    let name: String
    let height = 10.234
    let age: Int
    let storage: [Int]
    let owner: Person
    let rect = CGRect(x: 10, y: 10, width: 100, height: 100)
    let rects = [CGRect(x: 10, y: 10, width: 100, height: 100), CGRect(x: 20, y: 20, width: 200, height: 200)]
    let personList = [Person(name: "Mr.A", age: 21), Person(name: "Mr.B", age: 21), Person(name: "Mr.C", age: 21)]
    let arrayOfArray = [[1,2,3], [4,5,6]]
    let myDictionary: [String: Any] = [
        "One": Person(name: "Mr.A", age: 21, gender: .female),
        "Two": person,
        "Three": person2,
        "Four": 4
    ]
    let dictionary2 = [
        "123": 123,
        "1234": 12
    ]
    let image = UIImage()//Not supported
}


enum Gender {
    case male(String, Int)
    case female
    case unknown
}


let person = Person(name: "Jim", age: 21)
let person2 = Person(name: "YH", age: 22, gender: .unknown)
let contact = Contact(name: "John", age: 22, storage: [1,3,4,5,2,3,4], owner: person)

func runDictTest(_ target: Any) {
    print("====================================================")
    let dict = YHJSONGenerator.JSONDict(from: target)!
    print(dict)
    print(JSONSerialization.isValidJSONObject(dict))
    print()
    print()
}


func runArrayTest(_ target: Any) {
    print("====================================================")
    let array = YHJSONGenerator.JSONArray(from: target)!
    print(array)
    print(JSONSerialization.isValidJSONObject(array))
    print()
    print()
}


func run() {
//    runDictTest([person2, person, "Hello World", 123, CGSize(width: 100, height: 99)])
    runDictTest(person)
    runDictTest(person2)
    runDictTest(contact)
    
    runArrayTest([person2, person, "Hello World", 123, CGSize(width: 100, height: 99)])
}
