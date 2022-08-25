# 제네릭(Generics)
1. 제네릭, 왜 필요할까 ?
    - 만약 변수를 서로 바꾸는 swap 함수가 존재한다고 하자.
    - 변수의 타입별로 함수를 만들어 줘야 하는 불편함이 있다.
        - ex) Int, Stirng, Double... 별로 함수를 만들어야 함.
    - 따라서, 제네릭의 개념이 없다면 함수를 모든 경우마다 다시 정의해야 한다.
```swift
// 기존 문법
var num1 = 10
var num2 = 20

// Double, Stirng 적용 가능
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temp = a
    a = b
    b = temp
}

func swapTwoDouble(_ a: inout Double, _ b: inout Double) {
    let temp = a
    a = b
    b = temp
}
// 형식에 따라 함수의 개수가 증가한다.

swapTwoInts(&num1, &num2)
```

2. 제네릭 문법
    - 형식에 관계없이 한번의 구현으로 모든 타입을 처리하며, 타입에 유연한 함수 작성 가능
        - 유지보수, 재사용성 증가
    - 타입 파라미터는 함수 내부에서 파라미터 형식이나 리턴형으로 사용됨(함수 바디에서도 사용 가능)
    - 보통 `T`를 사용하지만, 다른 이름을 사용하는 것도 문제가 없음.
        - 형식 이름이기 때문에 UpperCamelCase로 선언
        - 2개 이상 선언 가능
    - 제네릭은 타입에 관계없이 하나의 정의로 모든 타입의 자료형을 처리할 수 있는 문법
    - 제네릭 함수, 제네릭 클래스/구조체..
    - 일반 함수와 비교하면 작성해야 하는 코드의 양이 감소
3. 제네릭 함수의 정의
    - 타입 파라미터 `<T>`는 함수의 내부에서 파라미터의 타입이나 리턴형으로 사용됨
        - 관습적으로 Type의 약자인 대문자 T를 사용하지만 다른 문자를 사용해도 됨
    - 1 ) 타입 파라미터의 지정 : 함수의 이름 마지막에 < > 를 쓰고 안에 타입 파라미터 작성
    - 2 ) 타입 파라미터의 사용 : 본래 타입의 사용하는 위치에서 타입이 필요한 곳에 타입 파라미터 사용
        - 실제 함수 호출시 실제 타입으로 치환됨
```swift
// 타입 T만 사용가능. 즉, String, String은 가능하나 String, Int는 불가능하다.
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}
```
4. 구조체, 클래스, 열거형에서의 적용
```swift
// 구조체
struct Member {
    var members: [String] = []
}

struct GenericMember<T> {
    var members: [T] = []
}

// 멤버와이즈 이니셜라이저 제공
var member1 = GenericMemeber(members: ["Jobs", "Cook", "Musk"])
var member2 = GenericMemeber(members: [1, 2, 3])

// 클래스
class GridPoint<A> {
    var x: A
    var y: A

    init(x: A, y: A) {
        self.x = x
        self.y = y
    }
}

let aPoint = GridPoint(x: 10, y: 20)
let bPoint = GridPoint(x: 10.4, y: 20.5)

// 열거형
enum Pet<T> {
    // 케이스는 자체가 선택항목중에 하나일 뿐
    // 그것을 타입으로 정의할 일은 없음
    case dog
    case cat
    case etc(T)
}

let animal = Pet.etc("고슴도치")
```
5. 제네릭 구조체의 확장
```swift
struct Coordinates<T> {
    var x: T
    var y: T
}

// 제네릭을 확장에서 적용 가능, 확장 대상을 제한하는 것도 가능은 하다.
extension Coordinates {
    // 튜플로 리턴하는 메서드
    func getPlace() -> (T, T) {
        return [x, y]
    }
}

let place = Coordinates(x: 5, y: 5)
place.getPlace()

// where을 통해 정수에서만 적용 가능하게 함
extension Coordinates where T == Int {
    func getIntArray() -> [T] {
        return [x, y]
    }
}
```
6. 타입 제약(Type Constraint)
    - 제네릭에서 타입을 제약할 수 있음
    - 타입 매게변수 이름 뒤에 클론으로 "프로토콜" 제약조건 또는 "단일 클래스"를 배치 가능하다.
        - 프로토콜 : <T: Equatable>
        - 클래스 : <T: SomeClass>
```swift
// Equatable 프로토콜을 채택한 타입만 해당 함수에서 사용가능 하다는 제약
func findIndex<T: Equatable>(item: T, array: [T]) -> Int? {
    for (index, value) in array.enumerated() {
        if item == value {
            return index
        }
    }
    return nil
}

// 반대로 구체/특정화 함수도 구현 가능함
func findIndex(item: String, array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if item.caseInsensitiveCompare(value) == .orderedSame {
            return index
        }
    }
    return nil
}

let aNumber = 5
let someArray = [3, 4, 5, 6, 7]

if let index = findIndex(item: aNumber, array: SomeArray) {
    print("밸류값과 같은 배열의 인덱스 : \(index)")

}

// 특정 클래스와 상속관계 내에 있는 클래스만 타입으로 사용할 수 있다는 제약
class Person { }
class Student: Person { }

// 해당 함수를 사용하려면 Person 클래스와 관련이 있어야 한다
func personClassOnly<T: Person>(array: [T]) {

}

let person = Person()
let student = Stduent()

personClassOnly(array: [person, person])
personClassOnly(array: [person, student])
personClassOnly(array: [student, student])
```
7. 프로토콜에서의 제네릭 문법의 사용(Associated Types: 연관 타입)
    - 프로토콜을 제네릭 방식으로 선언하려면? 연관 타입으로 선언해야 함.
    - 프로토콜은 타입들이 채택할 수 있는 한차원 높은 단계에서 요구사항만을 선언하는 개념이기 때문에, 제네릭 타입과 조금 다른 개념을 추가적으로 도입
        - `<T>` -> `associatedtype T`
```swift
// 프로토콜의 선언
protocol RemoteControl {
    associatedtype T
    func changeChannel(to: T)
    func alert() -> T?
}

// 사용 방법
struct TV: RemoteControl {
    typealias T = Int // 생략 가능

    func changeChannel(to: Int) {
        print("채널 바꿈 : \(to)")
    }

    func alert() -> Int? {
        return 1
    }
}

class Aircon: RemoteControl {
    func changeChannel(to: String) {
        print("에어컨 온도 변경 : \(to)")
    }

    func alert() -> String? {
        return "1"
    }
}

// 연관 형식에 제약을 추가한다면 ?
protocol RemoteControl2 {
    associatedtype Element: Equatable
    func changeChannel(to: Element)
    func alert() -> Element?
}
```