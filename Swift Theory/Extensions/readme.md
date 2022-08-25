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
    - 클래스
        - 클래스의 경우 편의 생성자만 추가할 수 있으며, 지정 생성자 및 소멸자는 반드시 본체에 구현해야 함
        - 지정생성자 및 소멸자 추가 불가
    - 구조체
        - 편의 생성자가 존재하지 않고 상속과 관련이 없어 * 지정 생성자의 형태로도 생성자 구현 가능 *
        - 생성자를 추가하여본체의 지정 생성자를 호출하는 방법으로 구현 가능
        - 새롭게 지정 생성자 형태로 구현하는 것도 가능
        - 직접 생성자를 구현하면 기본 생성자 init(), 멤버와이즈 생성자 제공 안되는 것이 원칙
        - 모든 저장속성에 기본값을 제공하고 본체에 직접 생성자를 구현하지 않는다면 확장에서 괜찮음
```swift
// 구조체
struct Point {
    var x = 0.0, y = 0.0

    // init(x: Double, y: Double)

    // init()
}

struct Size {
    var width = 0.0, height = 0.0
}

// 기본값을 제공하고 생성자를 구현 안함 => 기본 생성자, 멤버와이즈 생성자가 자동 제공중
struct Rect {
    var origin = Point()
    var size = Size()
}

let defaultRect = Rect()

let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)

        // 본체의 멤버와이즈 생성자 호출 방식으로 구현 가능
        self.init(origin: Point(x: originX, y: originY), size: size)

        // 직접 값을 설정할 수 있음
        self.origin = Point(x: originX, y: originY)
        self.size = size
    }
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))

// 클래스
var color = UIColor(red: 0.3, green: 0.5, blue: 0.4, alpha: 1)

extension UIColor { // 확장: 편의 생성자
    convenience init(color: CGFloat) {
        self.init(red: color/255, green: color/255, blue: color/255, alpha: 1)
    }
}

UIColor(color: 1)
```
5. 서브스크립트
    - 메서드이므로 가능함 !
```swift
extension Int {
    subscript(num: Int) -> Int {

        var decimalBase = 1

        for _ in 0..<num {
            decimalBase *= 10
        }

        return (self / decimalBase) % 10
    }
}

123456789[0]      // (123456789 / 1) ==> 123456789 % 10 ==> 나머지 9
123456789[1]      // (123456789 / 10) ==> 12345678 % 10 ==> 나머지 8
123456789[2]      // (123456789 / 100) ==> 1234567 % 10 ==> 나머지 7
123456789[3]      // (123456789 / 1000) ==> 123456 % 10 ==> 나머지 6

// Int값에 요청된 자릿수가 넘어간 경우 0 반환
746381295[9]     // 0
```
6. 새로운 중첩 타입 정의 및 사용(Nested Types)
    - ex) 클래스 안에 클래스, 구조체 등을 만들 수 있음. 이걸 중첩타입이라 함
```swift
// 예시 1
extension Int {
    enum Kind {
        case negative, zero, positive
    }

    var kind: Kind {
        switch self {
        case 0:
            return kind.zero
        case let x where x > 0:
            return kind.positive
        default:
            return kind.negative
        }
    }
}

// 예시 2
func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("- ", terminator: "")
        case .zero:
            print("0 ", terminator: "")
        case .positive:
            print("+ ", terminator: "")
        }
    }
    print("")
}

printIntegerKinds([3, 19, -27, 0, -6, 0, 7])      // + + - 0 - 0 +
```
7. 프로토콜 채택 및 프로토콜 관련 메서드
    - 프로토콜에 대한 확장도 가능