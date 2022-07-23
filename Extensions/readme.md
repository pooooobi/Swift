# 확장(Extensions)
클래스, 구조체, 열거형에서 현재 존재하는 타입에 기능(메서드)를 추가하여 사용하는 것.
```swift
class SomeType{
    // ...etc
}

extension SomeType {
    // ...etc
}
```
기존 타입에 `extension` 키워드를 사용하여 확장하고 새로운 기능을 정의(메서드 형태를 추가)할 수 있다.<br>
확장이 정의되기 전 생성된 경우에도 기존 인스턴스에서 새 기능을 사용한다 !
```swift
class Person {
    var id = 0
    var name = "name"
    var email = "test@test.com"

    func walk() {
        print("걷는다.")
    }
}

class Student: Person {
    var studentId = 1

    override func walk() {
        print("학생이 걷는다.")
    }

    func study() {
        print("학생이 공부한다.")
    }
}

// 확장의 예시
// 스위프트에서 구현한 메서드에 대한 재정의를 할 수 없으나 @objc 붙이면 가능함
extension Student {
    func play() { // 여기에 @objc 써야 다른곳에서 재정의(override) 가능함.
        print("학생이 논다")
    }
}

class Undergraduate: Student {
    var major = "전공"

    override func walk() {
        print("대학생이 걷는다.")
    }

    override func study() {
        print("대학생이 공부한다.")
    }

    func party() {
        print("대학생이 파티한다.")
    }
}

// 확장의 장점

extension Int {
    var squared: Int {
        return self * self
    }
}
```

## 확장 가능 멤버
1. 기본적으로 저장속성은 정의할 수 없다.
2. (타입) 계산 속성, (인스턴스) 계산 속성
```swift
// (타입) 계산 속성
extension Double {
    static var zero: Double { return 0.0 }
}

// (인스턴스) 계산 속성
extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0}
    var ft: Double { return self / 3.28084 }
}
let oneInch = 25.4.mm
let threeFeet = 3.ft
```
3. (타입) 메서드, (인스턴스) 메서드
```swift
// (타입) 메서드
extension Int {
    static func printNumbersFrom1to5() {
        for i in 1...5 {
            print(i)
        }
    }
}
Int.printNumbersFrom1to5()

// (인스턴스) 메서드
extension String {
    func printHelloRepetitions(of times: Int) {
        for _ in 0..<times {
            print("Hello \(self) !")
        }
    }
}
"Steven".printHelloRepetitions(of: 4)

// mutating 인스턴스 메서드의 확장
extension Int {
    mutating func square() {
        self = self * self
    }
}
```
4. 새로운 생성자
    - 단, 클래스의 경우 편의 생성자만 추가할 수 있으며, 지정 생성자 및 소멸자는 반드시 본체에 구현해야 함
5. 서브스크립트
6. 새로운 중첩 타입 정의 및 사용
7. 프로토콜 채택 및 프로토콜 관련 메서드
    - 프로토콜에 대한 확장도 가능