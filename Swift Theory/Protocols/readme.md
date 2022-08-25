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
5. 서브 스크립트
    - get, set 키워드를 통해서 읽기, 쓰기 여부를 결정한다.
    - get => 최소한 읽기 서브 스크립트 구현, set도 추가 가능하다.
    - get/set => 반드시 읽기, 쓰기 둘 다 구현해야 함
```swift
protocol DataList {
    subscript(idx: Int) -> Int { get }
}

struct DataStructure: DataList {
    // get만 요구해서 set도 구현할 수 있음
    subscript (idx: Int) -> Int {
        get {
            return 0
        }
    }
}
```
6. 확장
```swift
protocol Certificate {
    func doSomething()
}

class Person { 

}

// 관습적으로 본체보다는 확장에서 프로토콜을 구현한다.
// 그래야 코드가 깔끔해진다.
extension Person: Certificate {
    func doSomething() {
        print("DO SOMETHING FUNCTION")
    }
}
```

## 타입으로써의 프로토콜
1. 프로토콜은 타입이다.
    - 프로토콜을 변수에 할당할 수 있음
    - 함수를 호출할 때, 프로토콜을 파라미터로 전달할 수 있음
    - 함수에서 프로토콜을 반환할 수 있음
    - 프로토콜은 일급 객체(First class citizen)이므로 타입(형식)으로 사용할 수 있음
```swift
protocol Remote {
    func turnOn()
    func turnOff()
}

class TV: Remote {
    func turnOn() {
        print("TV ON")
    }

    func turnOff() {
        print("TV OFF")
    }
}

struct SetTopBox: Remote {
    func turnOn() {
        print("SETTOPBOX ON")
    }

    func turnOff() {
        print("SETTOPBOX OFF")
    }

    func doNetflix() {
        print("NETFLIX ON")
    }
}

// 프로토콜 타입인 Remote로 가능하다.
let tv: Remote = TV() 
let sbox: SetTopBox = SetTopBox() // 단, Remote 타입이 되면 doNetflix를 실행할 수 없음
(sbox as! SetTopBox).doNetflix()
```
2. 프로토콜 타입 취급의 장점
    - 상속에서 다룬 것처럼 배열에 담을 수 있다.
```swift
let electronic: [Remote] = [tv, sbox]

// 켜기, 끄기만 가능하여 타입캐스팅도 필요 없음(단, 위에서 설명했듯 프로토콜의 멤버만 사용가능)
for item in electronic {
    item.turnOn()
}

// 예시 2
func turnOnSomeElectronics(item: Remote) {
    item.turnOn()
}

turnOnSomeElectronics(item: tv)
turnOnSomeElectronics(item: sbox)
```
3. 프로토콜 준수성 검사
    - is, as 연산자 사용 가능
    - is => 특정 타입이 프로토콜을 채택하고 있는지 확인
    - as => 타입 캐스팅(특정 인스턴스 프로토콜로 변환하거나, 프로토콜을 인스턴스 실제형식으로 캐스팅)
```swift
// is
tv is Remote // true
sbox is Remote // true

// 프로토콜 타입으로 저장된 인스턴스가 더 구체적인 타입인지 확인 가능하다
electronic[0] is TV // true
electronic[1] is SetTopBox // true

// as
// UpCasting
let newBox = sbox as Remote
newBox.turnOn()
newBox.turnOff()

// DownCasting
let sbox: SetTopBox? = electronic[1] as? SetTopBox
sbox2?.doNetflix()

// (electronic[1] as? SetTopBox)?.doNetflix()
```

## 프로토콜의 상속
1. 프로토콜도 상속이 가능하다.
    - B, C Protocol이 A Protocol을 상속한다면 B Protocol을 채택하면 A, B를 구현해야 하고.. C는 A, C를 구현해야 한다.
2. 프로토콜은 다중 상속을 지원한다.
    - 그리고 프로토콜간 상속도 가능하다.
```swift
protocol Remote {
    func turnOn()
    func turnOff()
}

protocol AirConRemote {
    func Up()
    func Down()
}

protocol SupetRemoteProtocol: Remote, AirConRemote {
    // Remote, AirConRemote Protocol의 내용 담겨있음
    func doSomething()
}

class HomePot: SuperRemoteProtocol {
    func turnOn() { }
    func turnOff() { }
    func Up() { }
    func Down() { }
    func doSomething() { }
}
```
3. 프로토콜을 클래스 전용으로 만들 수 있다.
    - `AnyObject`는 클래스 전용 프로토콜이다.
    - 프로토콜에 상속시키면 클래스 전용이 된다.
```swift
protocol SomeProtocol: AnyObject {
    func doSomething()
}

class AClass: SomeProtocol {
    func doSomething() {
        print("DO SOMETHING")
    }
}
```
4. 프로토콜 합성(Protocol Composition) 문법 존재
```swift
protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

// 프로토콜을 다중 상속할 수 있음
struct Person: Named, Aged {
    var name: String
    var age: Int
}

// 프로토콜을 두개로 병합할 수 있음 => '&' 사용
func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy Birthday, \(name) ! You're \(age) years old.")
}
```

## 프로토콜의 선택적 요구사항의 구현(Optional Protocol Requirements)
1. 프로토콜에서 선언한걸 선택적으로 구현할 수 있다.
    - 어트리뷰트 키워드 사용함.
    - Objective-C에 해당하는 클래스 전용 프로토콜임(구조체, 열거형 불가)
        - Objective-C는 구조체와 열거형에서 프로토콜을 지원하지 않음
    - 따라서, 프로토콜도 @objc로 선언해야 하고, 내부에서 선택형을 @objc optional로 선언해야 한다.
```swift
@objc protocol Remote {
    @objc optional var isOn: Bool { get set }
    func turnOn()
    func turnOff()
    @objc optional func doNetflix()
}

class TV: Remote {
    var isOn = false

    func turnOn() { }
    func turnOff() { }
}
```

## 프로토콜의 확장(Protocol Extension)
1. 프로토콜을 채택할 경우 실제로 구현해야 한다.
2. 여러 타입에서 채택한다면 반복 구현해야 하는데, 프로토콜 확장을 제공하여 메서드의 디폴트 구현을 제공한다.
```swift
extension Remote {
    // 채택시 해당 메서드
    func turnOn() { print("리모콘 켜기") }
    func turnOff() { print("리모콘 끄기") }
    
    // 타입에 따른 선택
    func doAnotherAction() { print("리모콘의 다른 동작") }
}
```

## 프로토콜 지향 프로그래밍
1. 여러개의 프로토콜 채택 가능(다중 상속과 유사하다)
2. 메모리 구조에 대한 특정 요구사항 없음
    - 필요한 속성, 메서드만 채택 가능(@objc optional)
3. 모든 타입에서 채택 가능(밸류 타입도 가능하다.)
4. 타입으로 사용 가능해서 활용성이 높다.
5. 따라서 보다 나은 구성과 재사용성을 높일 수 있다.
6. 프로토콜 지향 프로그래밍을 잘 사용하면 애플이 만들어 놓은 데이터 타입에도 채택하여 활용 가능함.

## 프로토콜 확장의 적용 제한
1. 프로토콜의 확장에서 where절을 통해 프로토콜 확장의 적용을 제한할 수 있다.
2. 특정 프로토콜을 채택한 타입에만 확장이 적용되도록 제한한다.
    - `where Self: 특정 프로토콜`
```swift
extension Bluetooth where Self: Remote {
    func blueOn() { print("블루투스 켜기") }
    func blueOff() { print("블루투스 끄기") }
}

// Remote 프로토콜을 채택한 타입만 Bluetooth의 확장이 적용된다.
// Remote 프로토콜을 채택하지 않으면 Bluetooth 확장 적용 불가
class SmartPhone: Remote, Bluetooth {

}
```