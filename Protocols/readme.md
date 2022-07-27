# 프로토콜(Protocols)
`Protocol : 규약, 협약`의 의미를 지닌다.
1. 프로토콜, 왜 필요한가?
    - 아래 코드에서는 비행기도 알을 낳을 수 있다.
    - 비행기도 암컷, 수컷이 있는가 ? (있다면 연구대상감...)
```swift
// 유데미 안젤라님 강의에서..
class Bird {
    var isFemale = true

    func layEgg() {
        if isFemale {
            print("새가 알을 낳는다.")
        }
    }

    func fly() {
        print("새가 날아간다.")
    }
}

class Eagle: Bird {
    func soar() {
        print("공중으로 솟아오른다.")
    }
}

class Penguin: Bird {
    // 상속 구조에 따라 fly()가 자동으로 상속됨
    func swim() {
        print("헤엄친다.")
    }
}

class Airplane: Bird {
    // 상속 구조에 따라 layEgg()가 상속됨
    override func fly() {
        print("비행기가 엔진을 사용해서 날아간다.")
    }
}

struct FlyingMuseum {
    func flyingDemo(flyingObject: Bird) {
        flyingObject.fly()
    }
}

let myEagle = Eagle()
myEagle.fly()
myEagle.layEgg()
myEagle.soar()

let myPenguin = Penguin()
myPenguin.layEgg()
myPenguin.swim()
myPenguin.fly()     // 문제 ===> 펭귄이 날개 됨(무조건적인 멤버 상속의 단점)

let myPlane = Airplane()
myPlane.fly()
myPlane.layEgg()         // 문제 ===> 비행기가 알을 낳음

let museum = FlyingMuseum()     // 타입 정의 ===> 오직 Bird 클래스 밖에 안됨
museum.flyingDemo(flyingObject: myEagle)
museum.flyingDemo(flyingObject: myPenguin)
museum.flyingDemo(flyingObject: myPlane)    // Bird를 상속해야만 사용 가능
```
2. 프로토콜의 적용
```swift
protocol CanFly() {
    func fly()
}

class Bird1 {
    var isFemale = true

    func layEgg() {
        if isFemale {
            print("새가 앓을 낳는다.")
        }
    }
}

class Eagle1: Bird1, CanFly {
    func fly() {
        print("독수리가 하늘로 날아올라 간다.")
    }

    func soar() {
        print("공중으로 활공한다.")
    }
}
```
2. 1 . 자바와의 비교
    - 필요한 내용을 정의하고, 클래스에서 구현한다.
    - 자바의 인터페이스와 스위프트의 프로토콜은 매우 유사하다. 참고하자.
```java
public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByEmail();
}
```

## 프로토콜의 문법
1. 프로토콜을 정의한다.
    - 클래스에서 상속이 있는 경우
        - 상위 클래스를 먼저 선언한다.
        - 프로토콜 채택을 선언한다.
```swift
protocol MyProtocol {
    // 내부 내용...
    func doSomething() -> Int
}
```
2. 프로토콜을 채택한다.
```swift
class FamilyClass {
    // 내용...
}

class MyClass: FamilyClass, MyProtocol {
    func doSomething() -> Int {
        return 1
    }
}
```

## 프로토콜 요구사항
1. 프로토콜 요구사항의 종류
    - 속성 요구사항
    - 메서드 요구사항(메서드, 생성자, 서브스크립트)
2. 속성의 요구사항을 정의
    - 속성의 뜻에서 var로 선언(let 불가)
    - get, set 키워드를 통해 읽기, 쓰기 여부 설정(최소한의 요구사항)
    - 저장 속성, 계산 속성 모두 가능하다.
```swift
protocol RemoteMouse {
    // let, var, 읽기 계산속성, 읽기, 쓰기 계산속성
    var id: String { get }

    // var, 읽기, 쓰기 저장속성
    var name: String { get set }

    // 타입 저장 속성(static), 타입 계산 속성(class)
    static var type: String { get set } // => class로 구현 가능함.
}

struct TV: RemoteMouse {
    var id: String = "12"

    var name: String = "Samsung TV"

    static var type: String = "리모콘"
}
```
3. 메서드의 요구사항 정의
    - 메서드의 헤드 부분(in/out)의 형태만 요구사항으로 정의
    - mutating 키워드 => 구조체로 제한하지 않음. 구조체도 채택 가능하다는 의미.
    - 타입 메서드로 제한 => static 키워드를 붙이면 됨.
        - 구현하려는 쪽에서 static, class 모두 사용 가능하다 !
```swift
// 예시 1
protocol RandomNumber {
    static func reset()
    func random() -> Int
    // mutating func doSomething()
}

// 클래스 예시
class Number: RandomNumber {
    static func reset() {
        print("리셋")
    }

    func random() -> Int {
        return Int.random(in: 1...100)
    }
}

// 구조체 예시
struct Number: RandomNumber {

    var num = 0

    static func reset() {
        print("리셋")
    }

    mutating func doSomething() {
        self.num = num
    }
}

// 예시 2
protocol Togglable {
    mutating func toggle()
}

// 열거형(구조체) 예시
enum OnOffSwitch: Toggable {
    case on
    case off

    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}

// 클래스 예시
class BigSwitch: Togglable {
    var isOn = false

    func toggle() {
        isOn = isOn ? false : true
    }
}
```
4. 생성자 요구사항
    - 클래스는 생성자 앞에 required를 붙여 하위에서 구현을 강제해야 한다.
        - 구조체의 경우 상속이 없기 때문에, required는 필요없다.
    - 혹은 final을 붙여 상속을 막는다면 required를 생략할 수 있다.
    - 클래스에서 반드시 지정 생성자로 구현할 필요 없다 => 편의 생성자로 구현 가능하다.
    - 실패 가능, 불가능 생성자의 경우에는 다음과 같다.
        - init?() => init(), init?(), init!()로 구현한다.
        - init() => init?()로 구현할 수 없다. 범위가 넓어지면 안됨.
```swift
protocol SomeProtocol {
    init(num: Int)
}

// 예시 1
class SomeClass: SomeProtocol {
    required init(num: Int) { // required convenience init도 가능함. 위에서 3번째 확인.
        // 구현
    }
}

class SomeSubClass: SomeClass {
    // 하위 클래스에서 생성자 구현하지 않으면 필수 생성자는 자동 상속

    // required init(num: Int) => 이미 구현되어 있음
}

protocol AProtocol {
    init()
}

// 예시 2
class ASuperClass {
    init() {
        // 구현
    }
}

class ASubClass: ASuperClass, AProtocol {
    // AProtocol 채택하므로 required 필요, 상속으로 인한 override도 필요함
    required override init() {
        // 구현
    }
}

// 실패 가능 생성자 예시
protocol BProtocol {
    init?(num: Int)
}

// 구조체 예시
struct BStruct: BProtocol {
    // 구조체에선 required 필요 X
    
    // init?(num: Int) { }
    init(num: Int) { }
    // init!(num: Int) { }

    // 위 내용 다 가능하다 !
}

// 클래스 예시
class BClass: BProtocol {
    required init(num: Int) { 
        // 구현
    }
}
```