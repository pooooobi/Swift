## self 키워드와 Self 키워드
1. self 키워드는 아래와 같은 상황에서 사용한다.
    - 인스턴스를 가르키기 위해
    - 새로운 값으로 속성 초기화 가능한 패턴에서
    - 타입 메서드(멤버)에서
    - 타입 인스턴스를 가르키는 경우
```swift
// 인스턴스를 가르키기 위해
class Person {
    var name: String
    init(name: String) {
        self.name = name
    }
}

// 새로운 값으로(속성 초기화)
struct Calculator {
    var number: Int = 0

    mutating func plusNumber(_ num: Int) {
        number += num
    }

    mutating func reset() {
        self = Calculator()
    }
}

// 타입 멤버(메서드)에서
struct MyStruct {
    static let club = "iOS"

    static func doSomething() {
        print(self.club)
    }
}

// 타입 인스턴스를 가르키는 경우
class SomeClass {
    static let name = "SomeClass"
}

let myClass: SomeClass.Type = SomeClass.self
```
2. Self 키워드는 다음과 같은 상황에서 사용한다.
    - 특정 타입 내부에서 해당 타입을 가르키는 용도로
    - 프로토콜을 채택하는 해당 타입을 가르키는 용도로
```swift
// 특정 타입 내부(Int)에서 해당 타입(Self => Int)을 가르키는 경우
extension Int {
    static let zero: Self = 0 // Self => Int

    var zero: Self { // Self => Int
        return 0
    }

    static func toZero() -> Self {
        return Self.zero
    }

    func toZero() -> Self {
        return self.zero
    }
}

// 프롤토콜을 채택하는 해당 타입을 가르킴
extension BinaryInteger {
    func squared() -> Self {
        return self * self
    }
}

let x1: Int = -7
let y1: UInt = 7

if x1 <= y1 {
    print("\(x1) <= \(y1)")
} else {
    print("\(x1) > \(y1)")
}

// Int가 BinaryInteger 프로토콜을 채택
// Int에 기본 구현으로 squared() 제공 
```
