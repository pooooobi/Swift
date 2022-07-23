# 타입 캐스팅(Type Casting)
인스턴스의 타입을 검사(is 연산자) 하거나, 클래스 계층 상의 타입 반환(as 연산자)의 역할을 한다.
```swift
class Person {
    var id = 0
    var name = "name"
    var email = "test@test.com"
}

class Student: Person {
    var studentId = 1
}

class Undergraduate: Student {
    var major = "전공"
}
```

## 인스턴스 타입을 검사하는 is 연산자(type check operator)
`is` 연산자는 타입에 대한 검사를 수행하는 연산자다.
1. 인스턴스 is 타입(이항 연산자)
    - 참이면 true
    - 거짓이면 false
```swift
// 사용 방법
let person1 = Person()
let student1 = Student()
let undergraduate1 = Undergraduate()

person1 is Person // true
person1 is Student // false
person1 is Undergraduate // false

student1 is Person // true
student1 is Student // true
student1 is Undergraduate // false

undergraduate1 is Person // true
undergraduate1 is Student // true
undergraduate1 is Undergraduate // true

// 활용 예제
// 학생 인스턴스의 갯수 확인

let person2 = Person()
let student2 = Student()
let undergraduate2 = Undergraduate()

let people = [person1, person2, student1, student2, undergraduate1, undergraduate2]

var studentNumber = 0

for someOne in people {
    if someOne is Student {
        studentNumber += 1
    }
}

print(studentNumber)
```

## 인스턴스 타입의 (메모리 구조에 대한) 힌트를 변경하는 as 연산자
1. 업캐스팅(Upcasting)
    - 인스턴스 as 타입
    - 하위클래스의 메모리구조로 저장된 인스턴스를 상위 클래스로 인식
2. 다운캐스팅(Downcasting)
    - 인스턴스 as? 타입
        - 참이면 반환 타입은 Optional
        - 실패시 nil 반환
    - 인스턴스 as! 타입
        - 참이면 변환 타입은 Optional 타입의 값을 강제 언래핑한 타입
        - 실패시 런타임 오류
```swift
let ppp = person as? Undergraduate

// 활용 방법 (if let 바인딩), 다운 캐스팅
if let newPerson = person as? Undergraduate {
    newPerson.major
    print(newPerson.major)
}

// 업 캐스팅
let undergraduate2: Undergraduate = Undergraduate()
let person4 = undergraduate2 as Person

// Bridging => 서로 호환되는 형식을 캐스팅해서 쉽게 사용하는 것
// Swift에서 여전히 Objective-C 프레임워크를 사용하는 것이 많아 상호 호환 되도록 설계됨
let str: String = "Hello"
let otherStr = str as NSString
```

## 타입과 다형성(Polymorphism)
1. 다형성
    - 하나의 객체(인스턴스)가 여러 타입의 형태로 표현될 수 있다.
    - 다형성의 구현은 클래스의 상속, 프로토콜과 연관이 있음.
```swift
let people: [Person] = [Person(), Student(), Undergraduate()]

for person in people {
    person.walk()
}
```
상속 관계에서 다형성은 메서드를 통해 발현된다.<br>
업캐스팅된 타입 형태의 메서드를 호출하더라도 실제 메모리에서 구현된 재정의된 메서드가 호출되어 실행된다.

## Any, AnyObject를 위한 타입 캐스팅
1. 스위프트에서 제공하는 불특정한 타입을 다룰 수 있는 타입을 제공한다.
    - Any 타입
        - 기본 타입, 커스텀 클래스, 구조체, 열거형, 함수 타입까지도 포함하여 어떤 타입의 인스턴스도 표현할 수 있는 타입
        - Optional 포함
        - 저장된 타입의 메모리 구조를 알 수 없어 항상 타입캐스팅 해서 사용하야함.
        - 모든 타입을 담을 수 있는 배열 생성 가능
    - AnyObject 타입
        - 어떤 클래스 타입의 인스턴스도 표현할 수 있는 타입
```swift
// Any
var some: Any = "Swift"
let array: [Any] = [5, "Hello", 2.7, Person(), Superman(), {(name: String) in return name}]

// AnyObject
let objArray: [AnyObject] = [Person(), Superman(), NSString()]

// TypeCasting + 분기처리

for (index, item) in array.enumerated() {
    switch item {
    case is Int:
        print("INDEX: \(index), 정수")
    case let num as Double:
        print("INDEX: \(index), 소수 \(num)")
    case is String:
        print("INDEX: \(index), 문자열")
    case is (String) -> String:
        print("INDEX: \(index), 클로저 타입")
    default:
        print("INDEX: \(index), 이외의 타입임")
    }
}
```
2. 옵셔널의 Any 반환
    - 의도적으로 옵셔널을 사용하는 경우
        - Any는 모든 타입을 포함하므로 의도적으로 옵셔널 값을 사용하려면 Any 타입으로 변환하면 컴파일러가 알려주는 경고를 없앨 수 있음
    - 옵셔널 값은 임시적인 값으므로 옵셔널 바인딩을 통해 언래핑하여 사용하는데, Any로 변환한다는 것은 옵셔널을 사용하겠다는 의미임.
```swift
let optionalNum: Int? = 3
print(optionalNum) // 경고
print(optionalNum as Any) // 경고 X
```