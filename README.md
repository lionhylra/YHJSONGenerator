# YHJSONGenerator
A library to generate json object from almost any instance of class or struct.

# API
This library extends JSONSerialization with 3 methods:
```swift
 /// This method generates json object from any instance of a class or a struct, or a dictionary of valid item. **Note, This method only accept a instance of a class or a struct.**
    ///
    /// Define: A valid item is an object whose properties are all objects that conforms to JSONCompatible.
    /// - Parameter any: Any instance of a class or a struct
    /// - Returns: A json object whose root is a dictionary. If the parameter passed in is not a a instance of a class or struct, this method returns nil
    public static func jsonDictionaryObject(with any: Any) -> [String : Any]?

    /// This method generates json object from any array(or set) of instances. **Note, This method only accept a collection of valid items.**
    ///
    /// Define: A valid item is an object whose properties are all objects that conforms to JSONCompatible.
    ///
    /// - Parameter any: A collection of valid items.
    /// - Returns: A json object whose root is an array.
    public static func jsonArrayObject(with any: Any) -> [Any]?

    /// This method combines the `jsonDictionaryObject(with any: Any) -> [String: Any]?` and `jsonArrayObject(with any: Any) -> [Any]?`. In other words, it only accept a instance of a class or struct or a collection of valid items.
    ///
    /// - Parameters:
    ///   - any: Any instace
    ///   - opt: The options to write jsonObject
    /// - Returns: Data generated from JSON Object
    public static func jsonData(with any: Any, options opt: JSONSerialization.WritingOptions = default) throws -> Data
```

#### For example:
```swift
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
//print:
/*
  {
  "name" : "Swift Dinner",
  "location" : [
    123.456,
    789.123
  ],
  "meals" : [
    "breakfast",
    "lunch"
  ]
}
*/

let restaurants = [restaurant, restaurant, restaurant]
let restaurantsJSON = JSONSerialization.jsonArrayObject(with: restaurants)
//print:
/*
[
  {
    "name" : "Swift Dinner",
    "location" : [
      123.456,
      789.123
    ],
    "meals" : [
      "breakfast",
      "lunch"
    ]
  },
  {
    "name" : "Swift Dinner",
    "location" : [
      123.456,
      789.123
    ],
    "meals" : [
      "breakfast",
      "lunch"
    ]
  },
  {
    "name" : "Swift Dinner",
    "location" : [
      123.456,
      789.123
    ],
    "meals" : [
      "breakfast",
      "lunch"
    ]
  }
]
*/
```

#### These methods could convert any struct or class objects to JSON objects, as long as all the properties conforms to protol `JSONCompatible`. Here is a list of types conforms to `JSONCompatible` by default:
- ObjCBool
- Bool
- CGFloat

- String
- NSString

- Int
- Int8
- Int16
- Int32
- Int64

- UInt
- UInt8
- UInt16
- UInt32
- UInt64

- Float// aka. Float32
- Double// aka. Float64
- NSNull

- NSNumber

#### If your model contains properties that are not supported by JSON, you just need to make that type conform to `JSONConvertible`. You need to implement only one function toJSON() whitch returns a JSONCompatible type.
For example: If your model contains UIImage...
```swift
extension UIImage: JSONConvertible {
    public func toJSON() -> JSONCompatible {
        return UIImagePNGRepresentation(self)?.base64EncodedString() ?? ""
    }
}

struct Album {
    let name = "My album"
    var photo: UIImage = #imageLiteral(resourceName: "photo.jpg")
}


let album = Album()
let albumJSON = JSONSerialization.jsonDictionaryObject(with: album)
```

More examples:
```swift
extension URL: JSONConvertible {
    public func toJSON() -> JSONCompatible {
        return absoluteString
    }
}
extension Date: JSONConvertible {
    public func toJSON() -> JSONCompatible {
        return self.timeIntervalSince1970 * 1000
    }
}

```

#### To try the library yourself, you can download the repository and open Demo.playground.

# How to install
To use this library, just drag and drop YHJSONGenerator to your project.

# JSON to Swift?
If you are interested in converting JSON to Swift model. Please refer to my another repository: [SwiftJSONSolution](https://github.com/lionhylra/SwiftJSONSolution).
