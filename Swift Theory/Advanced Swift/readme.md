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

3. Comparable
```swift
/*
    [Comparable 요구사항]
    - static func < (lhs: Self, rhs: Self) -> Bool 메서드 구현
    - 일반적으로 < 만 구현하면 >, <=, >= 연산자도 자동 구현
    - Comparable 프로토콜은 Equatable 프로토콜을 상속하고 있음(필요시 == 구현해야 함)
    - 스위프트에서 제공하는 기본 숫자 타입 및 String은 모두 다 채택을 하고 있음(Bool은 채택하지 않음)
*/

let num1: Int = 123
let num2: Int = 456

num1 < num2 // true
num1 > num2 // false

let str1: String = "Hello"
let str2: String = "안녕"

str1 < str2 // true
str1 > str2 // false

/*
    [Int의 내부 구현]
    @frozen public struct Int: FixedWidthInteger, SignedInteger {
        ...
        public static func < (lhs: Int, rhs: Int) -> Bool
    }

    원칙) 구조체, 클래스의 모든 저장속성(열거형은 원시값이 있는 경우) Comparable을 채택한 경우라도 <(Less than) 연산자를 직접 구현해야 한다

    예외) 열거형의 경우 원시값이 없다면 Comparable을 채택만 하면 <(Less than) 연산자는 자동 제공
         원시값을 도입하는 순간 개발자가 직접 대응되는 값을 제공하므로 정렬 방식도 구현해야 한다는 논리
*/

// 열거형의 경우
enum Direction: Int {
    case east
    case west
    case south
    case north
}

extension Direction: Comparable {
    static func < (lhs: Direction, rhs: Direction) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

Direction.north < Direction.east // false
Direction.north > Direction.east // true

enum SuperComputer: Comparable {
    case cpu(core: Int, ghz: Double)
    case ram(Int)
    case hardDisk(gb: Int)
}

SuperComputer.cpu(core: 8, ghz: 3.5) < SuperComputer.cpu(core: 16, ghz: 3.5) //  true
SuperComputer.cpu(core: 8, ghz: 3.5) > SuperComputer.cpu(core: 8, ghz: 3.5) //  false

enum MyDirection: Comparable {
    case east
    case west
    case south
    case north
}

MyDirection.north < MyDirection.east // false
MyDirection.north > MyDirection.east // true

// 구조체의 경우
struct Dog {
    var name: String
    var age: Int
}

extension Dog: Comparable {
    // 이름 순인지 나이 순인지 구현해야 함
    static func < (lhs: Dog, rhs: Dog) -> Bool {
        return lhs.age < rhs.age
    }
}

let dog1: Dog = Dog(name: "초코", age: 10)
let dog2: Dog = Dog(name: "보리", age: 2)

dog1 < dog2 // false
dog1 > dog2 // true

// 클래스의 경우
class Person {
    var name: String
    var age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

extension Person: Comparable {
    // 클래스의 경우 ==도 구현해야 함
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name && lhs.age == rhs.age
    }

    // 나이순 정렬
    static func < (lhs: Person, rhs: Person) -> Bool {
        return lhs.age < rhs.age
    }
}

let person1: Person = Person(name: "홍길동", age: 20)
let person2: Person = Person(name: "임꺽정", age: 22)

person1 < person2 // true
person1 > person2 // false
```

4. Hashable
```swift
/*
    [Hashable 요구사항]
    func hash(into hasher: inout Hasher) 메서드의 구현
    이전 버전에서는 var hashValue: Int { get } 와 같이 hashValue 계산 속성으로 구현되어 있었으나 현재는 위의 방식으로 구현해야 한다.
    스위프트에서 제공하는 기본 숫자 타입은 모두 다 채택을 하고 있음
*/

let num1: Int = 123
let num2: Int = 456

// Int가 Hashable하기 때문에 Set의 원소가 될 수 있음
let set: Set [num1, num2]

let str1: String = "Hello"
let str2: String = "안녕"

// String이 Hashable하기 때문에 Set의 원소가 될 수 있음
let set2: Set = [str1, str2]

/*
    [Int의 내부 구현]
    extension Int: Hashable {
        @inlinable public func hash(into hasher: inout Hasher)

        public var hashValue: Int { get }
    }

    원칙) 구조체, 열거형의 경우 Hashable 프로토콜을 채택 시 모든 저장속성(열거형은 모든 연관 값)이 Hashable 프로토콜을 채택한 타입이라면, hast(into:)메서드 자동 구현
    예외) 클래스는 인스턴스의 유일성을 갖게 하기 위해서는 hash(into:) 메서드를 직접 구현해야하며, 클래스는 원칙적으로 Hashable 지원이 불가하다
         열거형의 경우 연관값이 없다면 기본적으로 Equatable/Hashable 하기 때문에 Hashable 프로토콜을 채택하지 않아도 됨
*/

// 열거형의 경우
enum SuperComputer: Hashable {
    case cpu(core: Int, ghz: Double)
    case ram(Int)
    case hardDisk(gb: Int)
}

let superSet: Set = [SuperComputer.cpu(core: 8, ghz: 3.5), SuperComputer.cpu(core: 16, ghz: 3.5)]

enum Direction {
    case east
    case west
    case south
    case north
}

let directionSet: Set = [Direction.north, Direction.east]

// 구조체의 경우
struct Dog {
    var name: String
    var age: Int
}

extension Dog: Hashable {}

let dog1: Dog = Dog(name: "초코", age: 10)
let dog2: Dog = Dog(name: "보리", age: 2)

let dogSet: Set = [dog1, dog2]

// 클래스의 경우
class Person {
    var name: String
    var age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

// Set에 넣고 싶어 Hashable 프로토콜 채택 => 클래스에서는 오류 발생
extension Person: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(age)
    }

    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name && lhs.age == rhs.age
    }
}

let person1: Person = Person(name: "홍길동", age: 20)
let person2: Person = Person(name: "임꺽정", age: 20)

let personSet: Set = [person1, person2]
```

5. CaseIterable
```swift
/*
    CaseIterable 프로토콜은 열거형(Enum) 타입에서만 사용할 수 있다.
    열거형에서 CaseIterable 프로토콜을 채택하면 타입 계산 속성이 자동으로 구현된다.
        - static var allCases: Self.AllCases { get }
    연관값이 없는 경우에만 채택 가능하다.
*/

enum Color: CaseIterable {
    case red, green, blue
}

Color.allCases // [Color.red, Color.green, Color.blue]

// 배열의 장점을 사용해 여러 편의적 기능 활용 가능
for color in Color.allCases {
    print("\(color)")
}

// 필요한 곳에서 간단하게
struct SomeView {
    let colors = Color.allCases
}

enum CompassDirection: CaseIterable {
    case north, south, east, west
}

// 케이스의 개수를 세기 편해짐
print("방향은 \(CompassDirection.allCases.count) 가지")

// 배열 => 고차함수 이용 가능
let caseList = CompassDirection.allCases
                                .map{ "\($0)" }
                                .joined(separator: ", ")

// 랜덤 케이스를 뽑아낼 수 있음
var randomValue = CompassDirection.allCases.randomElement()

// RPSGame(Application #3 참조)
enum RpsGame: Int, CaseIterable {
    case rock = 0
    case paper = 1
    case scissors = 2
}

let number = Int.random(in: 0...100) % RpsGame.allCases.count // 나머지를 구하는 것이므로 0, 1, 2중에 나옴

print(RpsGame.init(rawValue: number)!)

// 혹은
RpsGame.allCases.randomElement()
// 를 활용해서 적용해도 된다.
```

6. Never Type, 검증 함수
```swift
/*
    Never Type은 CPU에 제어권을 반납하지 않고 앱을 종료시킨다.

    Nonreturning(논리터닝 함수)
        - 제어권을 전달하지 않음
        - 명시적으로 제어권을 전달하지 않는다는 것을 표시하기 위해 Never 타입으로 선언
    
    Never 타입을 리턴하는 함수
        - 함수 내부에서 프로그램을 종료시켜야 함(fatalError())
        - 항상 에러를 던져서 catch 문에서 처리하도록 해야함(제어권을 catch로)

    Never 타입
        - 내부가 빈 열거형으로 선언
        - 인스턴스를 생성할 수 없음 : Uninhabited Type

    사용하는 이유 ?
        - 런타임에 발생할 수 있는 에러를 미리 발견하고, 검증 및 테스트하기 위해
*/

func crashAndBurn() -> Never {
    fatalError("앱 오류 발생, 종료")
}

/*
    fatalError() 함수에 대한 이해
    
    func fatalError(_ message: @autoclosure () -> String = String(), file: StaticString = #file, line: UInt = #line) -> Never

    1) message : 에러 발생 시 표시하려는 메세지
    2) file : 에러 발생 파일 이름
    3) line : 에러 발생 라인번호

    출시 이전 어플리케이션은 디버그 모드로 확인하게 되는데, assert 함수(검증 함수)로 확인하고
    출시 이후에는 precondition 함수(검증 함수)로 동작 시켜야 한다. => 앱을 일부로 종료시키는 상황

    assert() : 실제 앱을 출시할 때, 앱을 종료시켜야 할 정도의 상황은 아니지만 디버그 모드에서는 확인할 수 있는 것

    [디버깅 검즘 항수]
    - assert()
    - assertionFailure()
    - precondition()
    - preconditionFailure()
    - fatalError()
*/

// assert()
func enterWrongValue1() {
    let someWrongInput = -1
    assert(someWrongInput > 0, "유저가 값을 잘못 입력") // Assertion Error
}

func enterWrongValue2() {
    let someWrongInput = -1

    if someWrongInput > 0 {
        // 정상 처리 코드
    } else {
        assertionFailure("유저가 값을 잘못 입력") // Fatal Error
    }
}

// precondition() => 앱을 출시하고 나서도 일부로 크래시를 발생시켜 앱을 종료하게 끔 함
func appUpdateCheck1() {
    let update = false
    precondition(update, "앱을 업데이트 하지 않음")
}

func appUpdateCheck2() {
    let update = false
    if update {
        // 정상 처리 코드
    } else {
        preconditionFailure("앱을 업데이트 하지 않음")
    }
}
```

7. keyPath
    - 문자열 방식을 통해 속성에 간편하게 접근하기 위한 기술임
```swift
class School {
    var name: String
    var affiliate: SmallSchool

    init(name: String, affiliate: SmallSchool) {
        self.name = name
        self.affiliate = affiliate
    }
}

class SmallSchool {
    var classNumber: Person

    init(classMember: Person) {
        self.classMember = classMemeber
    }
}

class Person {
    var name: String
    init(name: String) {
        self.name = name
    }
}

let person1 = Person(name: "홍길동")
let smallSchool1 = SmallSchool(classMember: person1)
let school1 = School("슈퍼고", affiliate: smallSchool1)

// 이름에 접근하기 위해 써야하는 코드가 비약적으로 증가함
let gildongsName = school1.affiliate.classMember.name

// Swift 5의 KeyPath
let namePath = \School.affiliate.classMember.name
school1[keyPath: namePath]
```

8. selector
    - 메서드 주소를 통해 메서드를 가리키기 위한 기술임
```swift
// 메서드 주소를 통해 메서드를 사용하는 것
// 기본적으로 Objective-C 기술임

class Dog {
    var num = 1.0

    @objc var doubleNum: Double {
        get {
            return num * 2.0
        }
        set {
            num = newValue / 2.0
        }
    }

    @objc func run() {
        print("강아지가 달린다.")
    }
}

// 계산 속성을 가르킬 때
let eyesSelector = #selector(getter: Dog.doubleNum)
let nameSelector = #selector(setter: Dog.doubleNum)

// 메서드를 가르킬 때
let runSelector = #selector(Dog.run)
```

9. 메타 타입
```swift
class Dog {
    static let species = "Dog"
    var name: String = ""
    var weight: Double = 0.0
}

let dog1: Dog = Dog()

dog1.name = "초코"
dog1.weight = 10.0

let dog2: Dog = Dog()
dog2.name = "보리"
dog2.weight = 15.0

// 메타 타입은 타입(인스턴스, 메모리)의 타입임
let dogSelf: Dog.Type = type(of: dog1) // dog1의 인스턴스를 집어 넣음

Dog.species // => Dog.self.species

class Person {
    static let species = "Human"
    var name: String = ""
}

let person1: Person = Person()
person1.name = "홍길동"

let pSelf1: Person.Type = Person.self // species가 있는 영역으로 감
let pSelf2: Person.Type = type(of: person1) // person1의 영역으로 감

/*
    [Custom type]
    - 클래스이름.Type
    - 구조체이름.Type
    - 열거형이름.Type

    [Protocol type]
    - 프로토콜이름.Type
*/
```

10. available 키워드
```swift
// 새로운 업데이트 사항에 따라 iOS 이전 버전에서는 코드로 인한 크래시가 발생할 수 있기 때문에
// 어떤 버전 이상만 적용 가능 하다고 컴파일러에 힌트를 주는 것이다.

@available(iOS 11.0, *)
class ViewController: UIViewController {

    override func viewDiaLoad() {
        super.viewDiaLoad()
    }
}

@available(iOS 11.0, *)
func doSomething() {
    if #available(iOS 11.0, *) {
        // iOS 11 이상 적용시킬 코드
    } else {
        // iOS 11 미만 적용시킬 코드
    }
}
```