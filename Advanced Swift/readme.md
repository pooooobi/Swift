# 심화 내용(Advanced Swift)
1. 주요 프로토콜
    - Equatable : `==`, `!=` 비교 연산자 프로토콜(동일성 비교)
        - Comparable : `<`, `>`, `<=`, `>=` 연산자 관련 프로토콜(크기 비교, 정렬이 가능해짐)
        - Hashable : Hash 값을 갖게되어 값이 해셔블(유일한 값을 갖게 됨)해짐(Dictionary의 키, Set의 요소가 될 수 있음)

2. Equatable
```swift
/*
    [Equatable 요구사항]
    - static func == (lhs: Self, rhs: Self) -> Bool
    - 스위프트에서 제공하는 기본 타입은 모두 다 채택함
*/

let num1: Int = 123
let num2: Int = 456

num1 == num2 // false
num1 != num2 // true

let str1: String = "Hello"
let str2: String = "안녕"

str1 == str2
str1 1= str2

/*
    [Int의 내부 구현]
    @frozen public struct Int: FixedWidthInteger, SignedInteger {
        ...
        public static func == (lhs: Int, rhs: Int) -> Bool
        ...
    }

    동일성을 비교(==) 하려면 Equatable 채택 => 비교 연산자(==) 자동 구현

    원칙) 구조체, 열거형의 경우 Equatable 프로토콜 채택 시 모든 저장 속성(열거형은 모든 연관값)이 Equatable 프로토콜을 채택한 타입이라면 비교 연산자 메서드 자동 구현

    예외) 클래스는 인스턴스 비교를 하는 항동 연산자(===)가 존재하기 때문에 비교 연산자(==) 구현 방식에 대해 개발자에게 위임함
         열거형의 경우 연관값이 없다면 기본적으로 Equatable/Hashable 하기 때문에 Equatable 프로토콜을 채택하지 않아도 됨
*/

// 열거형
enum SuperComputer: Equatable {
    case cpu(core: Int, ghz: Double)
    case ram(Int)
    case hardDisk(gb: Int)
}

SuperComputer.cpu(core: 8, ghz: 3.5) == SuperComputer.cpu(core: 16, ghz: 3.5) // false
SuperComputer.cpu(core: 8, ghz: 3.5) != SuperComputer.cpu(core: 8, ghz: 3.5) // false

enum Direction {
    case east
    case west
    case south
    case north
}

Direction.north == Direction.east // false
Direction.north != Direction.east // true

// 구조체의 경우
struct Dog {
    var name: String
    var age: Int
}

extension Dog: Equatable { }

let dog1: Dog = Dog(name: "초코", age: 10)
let dog2: Dog = Dog(name: "보리", age: 2)

dog1 == dog2 // false
dog1 != dog2 // true

// 클래스의 경우
class Person {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

// 비교 연산자(==)를 직접 구현해야 함, Equatable 채택할 경우 ===만 자동 구현되기 때문
extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name && lhs.age == rhs.age
    }
}

let person1: Person = Person(name: "홍길동", age: 20)
let person2: Person = Person(name: "임꺽정", age: 20)

person1 == person2 // false
person1 != person2 // true
```

