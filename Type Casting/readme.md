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