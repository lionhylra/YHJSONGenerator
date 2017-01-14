
import Foundation
import CoreGraphics
import UIKit

//: ## Define test function
var testCount = 0

func printResult(jsonObject: Any?, title: String) {
    print()
    print("===================  \(title)  ========================")
    print("Begin test: \(testCount)")
    defer {
        testCount += 1
    }
    
    if let jsonObject = jsonObject {
        print("Is json object valid: ", JSONSerialization.isValidJSONObject(jsonObject))
        print("Pretty output: ")
        if let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted), let str = String(data: data, encoding: .utf8) {
            print(str)
        }
    } else {
        print("jsonObject is nill")
        return
    }
    
    print("End of test: \(testCount)")
    print("===========================================")
    print()
}

//: ## API - three functions added as JSONSerialization extensions
/*:
 ```swift
    JSONSerialization.jsonDictionaryObject(with: )
    JSONSerialization.jsonArrayObject(with: )
    JSONSerialization.jsonData(with:, options:)
 ```
 */
//: Simple usage, use example from apple's swift blog: https://developer.apple.com/swift/blog/?id=37

struct Restaurant {
    enum Meal: String {
        case breakfast, lunch, dinner
    }
    
    let name: String
    let location: (latitude: Double, longitude: Double)
    let meals: Set<Meal>
}

let restaurant = Restaurant(name: "Swift Dinner", location: (latitude: 123.456, longitude: 789.123), meals: [.breakfast, .lunch])

let restaurantJSON = JSONSerialization.jsonDictionaryObject(with: restaurant)
printResult(jsonObject: restaurantJSON, title: "Work With Struct")

let restaurants = [restaurant, restaurant, restaurant]
let restaurantsJSON = JSONSerialization.jsonArrayObject(with: restaurants)
printResult(jsonObject: restaurantsJSON, title: "Work With Array")


//: By default, the API supports instance of **valid struct/class**, array of **valid items**, and dictionary of String as key and **valid items** as value

//: A valid struct/class instance is thoses whose properties are valid item

//: A valid item is JSON supportted type in swift. They are `Dictionary`, `Array`, `String`, `Number`, and `Bool`

//: ## Try unsupported type

struct Album {
    let name = "My album"
    var photo: UIImage = #imageLiteral(resourceName: "photo.jpg")
}

let album = Album()
let albumJSON = JSONSerialization.jsonDictionaryObject(with: album)
printResult(jsonObject: albumJSON, title: "Work With Unsupported Type")

//: ## To support your non-JSON type

//: The only thing you need to do is to implement a protocol `JSONConvertible`

//: uncomment the code below to see the change of result above

//extension UIImage: JSONConvertible {
//    public func toJSON() -> JSONCompatible {
//        return UIImagePNGRepresentation(self)?.base64EncodedString() ?? ""
//    }
//}

//: ## Complicated Example

//: Define different types for complicated test. For convenience, most properties has a default value, then I don't need to init them in initialiser.

enum PropertyType: Int {
    case house
    case townHouse
    case apartment
    case unit
}


enum TradeType {
    case sell(price: Double)
    case lease(price: Double, contractPeriodByMonth: Int)
}


enum Gender: String {
    case male, female
}


class Person {
    var name: String
    weak var partner: Person?
    weak var sibling: Person?
    var age: Int = 20
    var properties: [Property] = []
    var height: Double = 178.0
    var contactList: [Person] = []
    var isAdult: Bool = true
    var weight: NSNumber = NSNumber(value: 60.5)
    var gender: Gender = .male
    var website: URL = URL(string: "https://www.google.com")!
    
    init(name: String) {
        self.name = name
    }
}


struct Property {
    var type: PropertyType = .house
    weak var owner: Person? = nil
    var size: CGSize = CGSize(width: 40, height: 50)
    let buildDate = Date()
    var tradeType: TradeType = .lease(price: 1450.67, contractPeriodByMonth: 12)
    let developerAndBuildYear: (String, Int) = ("XY Real Estate", 1992)//demo for tuple
}

//To support URL
extension URL: JSONConvertible {
    public func toJSON() -> JSONCompatible {
        return absoluteString
    }
}

// Uncomment code below to see what happens to date
//extension Date: JSONCompatible {
//    public func toJSON() -> JSONCompatible {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd-MM-yyyy"
//        return formatter.string(from: self)
//    }
//}



let jack = Person(name: "Jack")
let rose = Person(name: "Rose")
let santa = Person(name: "Santa Claus")
rose.gender = .female

jack.partner = rose
//rose.partner = jack//Uncomment this line to cause recursive lookup. Jack has rose, this rose has jack, jack has rose ...

jack.contactList = [rose, santa]


var house = Property()
house.owner = rose

jack.properties = [house]

if let jackJSON = JSONSerialization.jsonDictionaryObject(with: jack),
    let roseJSON = JSONSerialization.jsonDictionaryObject(with: rose),
    let house = JSONSerialization.jsonDictionaryObject(with: house) {
    
    printResult(jsonObject: jackJSON, title: "Test Jack")
}





