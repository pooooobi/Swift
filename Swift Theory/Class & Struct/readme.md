# 클래스(Class)와 구조체(Struct)
클래스는 객체지향 프로그래밍과 연관있는데, 클래스(틀)을 통해 객체를 생성하고 그 안에 들어있는 값을 정리한다고 보면 편하다.
```swift
// 클래스의 선언 -> 틀 생성
class Dog {
    var name = "이름"
    var weight = 0.0

    func sit() {
        print("앉았습니다.")
    }
    func layDown() {
        print("누웠습니다.")
    }
}

// 객체의 생성
var bori = Dog()

// 값에 접근하기
bori.name
bori.name = "보리"
bori.name

bori.weight
bori.weight = 3
bori.weight
```

## 클래스의 정의와 객체의 생성
위 코드를 바탕으로 책에 관한 내용으로 클래스를 정의하고 객체를 생성해보자.
```swift
// 클래스의 선언
class Book {
    // 속성(Property)
    var name = ""
    var price = 0
    var pages = 0
    
    // 메서드(Method)
    func showBookDetails() {
        print("책의 이름은 \(name), 가격은 \(price), 페이지는 \(pages) 페이지 입니다.")
    }
}

// 객체의 생성
var swiftBook = Book()

// 객체의 접근
swiftBook.name = "The Swift Programming"
swiftBook.price = 100
swiftBook.pages = 1200

// 객체 내 메서드 사용
swiftBook.showBookDetails()
```

## 구조체의 정의와 인스턴스(instance)의 생성
구조체 또한 클래스와 다르지 않다. 틀을 만드는 작업 또한 같은 일이고, `class`라고 적혀있는걸 `struct`(구조체) 라고 변경해도 된다.
```swift
// 구조체의 선언
struct Book {
    // 속성(Property)
    var name = ""
    var price = 0
    var pages = 0
    
    // 메서드(Method)
    func showBookDetails() {
        print("책의 이름은 \(name), 가격은 \(price), 페이지는 \(pages) 페이지 입니다.")
    }
}

// 인스턴스 생성
var swiftBook = Book()

// 인스턴스의 속성에 접근
swiftBook.name = "The Swift Programming"
swiftBook.price = 100
swiftBook.pages = 1200

// 인스턴스 내 메서드 사용
swiftBook.showBookDetails()
```

## 클래스와 구조체, 뭐가 다른가 ?
클래스와 구조체 둘다 메모리에 찍어낸 것을 인스턴스(instance)라고 한다.<br>
인스턴스는 실제 메모리에 할당되어 구체적 실체를 갖춘 것 이라는 의미이다.<br>
스위프트에서는 클래스의 instance를 `객체(Object)`라고 한다.
```text
클래스의 인스턴스(객체)
구조체의 인스턴스
열거형의 인스턴스
```
가장 큰 차이는 `메모리 저장 방식`의 차이이다.<br>
1. 구조체
    - 값 형식(Value Type)
    - 인스턴스(Instance) 데이터를 모두 스택(Stack) 영역에 저장한다.
    - 값을 전달하거나 복사시 복사본을 생성한다. (메모리 공간 추가 생성)
    - 스택 공간에 저장하며, 스택 프레임(StackFrame) 종료 시 자동 제거된다.

2. 클래스
    - 참조 형식(Reference Type)
    - 인스턴스 데이터는 힙에 저장하고, 해당 힙을 가르키는 변수는 스택에 저장한다.
    - 메모리 주소값이 힙(Heap)을 가르킨다.
    - 복사시 값을 전달하는 것이 아니고 지정 주소를 전달한다.
    - ⭐️ 힙 공간에 저장함에 따라 ARC 시스템을 통해 메모리 관리가 필요하다.

```text
위에서 Book이라는 클래스가 있다.
해당 클래스는 데이터 영역에 틀이 있고, 생성시 힙 영역에 보존된다.
swiftBook의 선언과 동시에 힙 영역에 존재하며, 스택 영역에서는 메모리 주소가 존재한다.

마찬가지로 구조체 또한 데이터 영역에 틀이 존재한다.
하지만 인스턴스를 선언하면 힙에 있지 않고, 스택 영역에 존재한다.
```

## 클래스와 구조체, let & var
```swift
class PersonClass {
    var name = "사람"
}

struct AnimalStruct {
    var name = "동물"
}

let pClass = PersonClass()
let aStruct = AnimalStruct()
```
둘은 무슨 차이가 있을까?<br>
1. `let`을 통한 선언시 클래스에서는 "메모리 주소를 변경할 수 없다"
    - 한가지만 가르키는데, 최초 선언한 pClass에서는 PersonClass의 메모리 주소만 가르킨다. 임의변경 불가
    - aStruct에서는 let으로 선언된 것이 스택 영역에서 보존되어 있다.
2. 따라서, `let`으로 선언 했다 하더라도 pClass는 내부 속성을 변경할 수 있으나 aStruct는 내부 속성을 변경할 수 없다.
```swift
// 가능
pClass.name = "사람1"

// 불가능
// aStruct.name = "동물1"
```

## 점문법 / 명시적 멤버 표현식(Explicit Member Expression)
`.`을 이용하여 내부의 요소(클래스와 구조체의 인스턴스의 속성)에 접근한다.
```swift
var man = PersonClass()
man.name = "테스트"

Int.random(in: 1 ... 10)
```

## 관습적인 선언
1. 속성과 메서드 순서대로 작성한다.
```swift
class Dog {
    var name = ""
    var weight = 0.0

    func sit() {
        print("앉았습니다.")
    }
}
```

## 생성자의 역할, 초기화의 의미
`init`메서드를 사용하여 생성자를 만들어 초기에 값을 넣을 수 있다.
```swift
class Dog {
    var name = "강아지"
    var weight = 0.0

    init(n: String, w: Double) {
        name = n
        weight = w
    }
}
```
만약 init에서 변수 이름이 같으면 어떻게 해야할까 ?
```swift
class Dog {
    var name = "강아지"
    var weight = 0.0

    init(name: String, weight: Double) {
        self.name = name
        self.weight = weight
    }
}
```
1. 모든 저장 속성(변수, property)을 초기화 해야한다. -> 구조체, 클래스 동일함.
2. 생성자 실행 종료시점에는 모든 속성의 초기값이 저장되어 있어야 함(초기화 되지 않는다면? 컴파일 오류 !)
3. 생성자의 목적은 저장 속성 초기화.
4. 클래스, 구조체, 열거형은 모두 설계도일 뿐, 실제 데이터(속성), 동작(메서드)을 사용하기 위해선 초기화 과정이 필요하다.

## 생성자(initializr) 와 self 키워드
인스턴스 내에서 동일한 변수, 상수명을 사용할 때 가르키는 것을 명확하게 하기 위해 `self` 키워드를 사용한다.
```swift
class Dog {
    var name = "강아지"
    var weight = 0.0

    init(name: String, weight: Double) {
        self.name = name
        self.weight = weight
    }
}
```
`self` 키워드는 클래스/구조체 내 해당 인스턴스(자기 자신)를 가르킨다.

## 속성이 옵셔널 타입일 경우
```swift
class Dog {
    var name: String?
    var weight: Int

    init(weight: Int) {
        // self.name = "강아지"
        self.weight = weight
    }

    func sit() {
        print("\(name) 앉았습니다.")
    }
    
    func layDown() {
        print("\(name) 누웠습니다.")
    }
}

var dog1 = Dog(weight: 10)
dog1.name // nil
```
String? 타입에 의해 init에 없어도 nil로 초기화 된다 생각하면 편하다.<br>
옵셔널 타입이기에 배웠던 옵셔널 바인딩으로 벗겨 사용할 수 있다.
```swift
if let name = dog1.name {
    print(name)
}

guard let name = dog1.name else { return }
print(name)
```

## 식별 연산자(Identity Operators)
두개의 참조가 같은 인스턴스를 가르키고 있는지를 비교하는 방법임.<br>
`===`, `!==`를 이용한다.
```swift
var dog1 = Dog(weight: 10)
var dog2 = Dog(weight: 15)

print(dog1 === dog2)
print(dog1 !== dog2)
```

## 클래스의 상속과 초기화(Class Inheritance & Initialization)
클래스에서 상속이라는 개념이 존재한다. 구조체에는 존재하지 않음 !!
1. 본질적으로 성격이 비슷한 타입을 새로 만들어 데이터(저장속성)을 추가하거나, 기능(메서드)를 변형시켜서 사용한다.
```swift
class Person {
    var id = 0
    var name = "이름"
    var email = "test@test.com"
}

class Student: Person {
    var studentId = 0
}

class Undergraduate: Student {
    var major = "전공"
}
```
위 코드를 살펴보면 Undergraduate(대학생)은 Student(학생)을 상속하고, Student(학생)은 Person(사람)을 상속한다.<br>
Undergraduate에서 Person의 id를 사용할 수 있고.. Student의 StudentId도 사용할 수 있다.<br>
메모리 공간을 살펴보면 다음과 같을 것이다.
```text
=====[Undergraduate]=====
|        major          |
|   ====[Student]====   |
|   |   studentId   |   |
|   |               |   |
|   |===[Person]=== |   |
|   ||     id     | |   |
|   ||    name    | |   |
|   ||   email    | |   |
|   |-------------- |   |
|   -----------------   |
-------------------------
```
이런 공간이 힙 스택에서 존재 할 것이다. 따라서 위에서 설명한 Undergraduate에서 id를 사용할 수 있는지 느낌을 알 수 있을것이다.<br>
상속은 하나만 가능하기에, 스위프트에서 다중 상속은 불가능하다.

2. 저장속성은 재정의 할 수 없다.
    - 재정의를 하려면 `override` 키워드를 붙여 사용하는데, 막상 저장속성은 오류가 날 것이다. 불가능하기 때문에...
3. 재정의(Overriding)
    - 오버라이딩은 클래스의 상속에서 상위 클래스의 속성, 메서드를 재정의(변형)하여 사용하는 것이다.
    - 서브클래스에서 슈퍼클래스의 동일한 멤버를 변형하여 구현하는 것.
    - 속성(저장속성에 대한 재정의는 절대 불가), 메서드(method, subscripts, init...)가 재정의 가능하나 둘이 방법이 다름.
```swift
// 오버라이딩의 기본 문법

// 슈퍼 클래스
class AClass {
    var aValue = 0

    func doSomething() {
        print("DO SOMETHING")
    }
}

// 서브 클래스
class BClass: AClass {
    // 저장속성은 재정의 할 수 없음. 단, 저장속성 => 계산속성 으로 재정의는 가능하다.
    override var aValue: Int {
        get {
            return 1
        }
        set {
            // super 키워드는 슈퍼 클래스의 aValue를 의미한다.
            super.aValue = newValue
        }
    }

    // 메서드는 재정의 가능!
    override func doSomething() {
        super.doSomething()
        print("DO SOMETHING 2")
    }
}
```
3. 1 . 속성의 재정의
    - 저장속성의 재정의 : 원칙적으로 불가능
        - 저장 속성은 고유의 메모리 공간이 있으므로 하위 클래스에서 변경 불가능함.
        - 단, 메서드 형태(계산 속성, 속성 감시자)로 추가하는 방식은 가능하다.
    - 계산 속성(메서드)의 재정의 : 기능의 범위를 축소하는 형태로는 재정의가 불가능함.
        - 상위에서 읽기만 가능하다면, 하위에서는 읽기 쓰기로 확장은 가능함.
        - 상위에서 읽기 쓰기가 모두 가능한데, 하위에서 읽기만 하는 방식은 불가능함.
    - 타입 저장 속성의 재정의 : 조건부 가능
        - static : 불가능
        - class : 가능
        - 재정의한 타입 저장/계산 속성에는 감시자 속성 추가 불가능.
```swift
// 속성의 재정의 예시
// 차량 클래스(슈퍼 클래스)
class Vehicle {
    var currentSpeed = 0.0

    var halfSpeed: Double {
        get {
            return currentSpeed / 2
        }
        set {
            currentSpeed = newValue * 2
        }
    }
}

// 오토바이 클래스(하위 클래스)
class Bicycle: Vehicle {
    // 저장속성 추가 가능
    var hasBasket = false

    // 저장속성 => 계산속성 재정의 가능.
    override var currentSpeed: Double {
        get {
            return super.currentSpeed
        }
        set {
            super.currentSpeed = newValue
        }
        /* 속성 감시자를 추가하는 재정의도 가능.
        willSet {
            print("\(currentSpeed) => \(newValue) 변경 예정")
        }
        didSet {
            print("\(currentSpeed) => \(newValue)로 변경됨")
        }
        */
    }
    
    // 계산 속성을 재정의 할 수 있음. 또한 재정의하면서 속성 감시자를 추가할 수 있음. (내용생략)
    override var halfSpeed: Double {
        get {
            return super.currentSpeed / 2
        }
        set {
            super.currentSpeed = newValue * 2
        }
    }
}
```
4. 메서드의 재정의
    - 속성에 비해 메서드의 재정의는 자유로움(단, 메모리 생성 규칙 존재)
    - 상위 클래스 인스턴스 메서드 또는 타입 메서드 상관 없이 기능을 추가하는 것 가능함.
    - 상위 기능을 무시하고 새롭게 구현하는 것 또한 가능함.
    - 기능 추가시 상위 구현기능을 사용할지 여부는 본인의 선택. `super.functionName()`
5. 초기화(Initialization)와 생성자(Initializer)
    - 초기화 -> 저장속성에 대한 초기값을 설정하여 인스턴스를 사용 가능한 상태로 만드는 것
    - 생성자 -> 인스턴스의 모든 저장속성이 초기값을 가지지 않기 때문에, 초기값을 만들게 끔 하는 것
```swift
// 생성자 구현의 기본
class Color {
    let red: Double
    let green: Double
    let blue: Double

    init() {
        red = 0.0
        green = 0.0
        blue = 0.0
    }

    // 생성자도 오버로딩 할 수 있음 !
    init(white: Double) {
        red = white
        green = white
        blue = white
    }

    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}
```
5. 1 . 초기화의 방법
    - 저장 속성의 선언과 동시에 값을 저장
    - 저장 속성을 옵셔널로 선언
    - 생성자에서 값을 초기화
    - ⚠️ 반드시 생성자를 정의할 필요는 없고, 위 1~2번 내용으로 해도 자동적으로 기본 생성자(Default)를 생성함.
5. 2 . 멤버와이즈 이니셜라이저(Memberwise Initializer)
    - 구조체는 멤버와이즈 이니셜라이져 자동 제공
```swift
struct Color {
    var red: Double = 1.0
    var green: Double = 1.0
    var blue
}

var a = Color(red: 1.0, green: 2.0, blue: 254.0)
```
6. 생성자(Initializer)
    - 구조체 : 지정 생성자, 실패 가능 생성자
    - 클래스 : 지정 생성자, 편의 생성자(상속관련), 필수 생성자(상속관련), 실패 가능 생성자
```swift
// 구조체의 지정 생성자
// 생성자 내에서 self.init(...)을 사용하여 다른 이니셜라이저를 호출하도록 할 수 있음
struct Color {
    let red, green, blue: Double

    init() {
        self.init(red: 0.0, green: 0.0, blue: 0.0)
    }

    init(white: Double) {
        self.init(red: white, green: white, blue: white)
    }

    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}

// 클래스의 지정 생성자, 편의 생성자
class Color {
    let red, green, blue: Double

    convenience init() {
        self.init(red: 0.0, green: 0.0, blue: 0.0)
    }

    convenience init(white: Double) {
        self.init(red: white, green: white, blue: white)
    }

    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}
```
6. 1 . 편의 생성자 : `convenience` 키워드 사용
    - 모든 속성을 초기화하지 않는다면 편의생성자로 만드는 것이 복잡도나 실수를 줄일 수 있다.
    - 클래스의 상속, 지정 생성자와 편의 생성자의 호출 규칙
```text
Delegate Up: 서브 클래스의 지정 생성자는 슈퍼 클래스의 지정 생성자를 반드시 호출해야 한다.
Delegate Across: 편의 생성자는 동일한 클래스에서 다른 이니셜라이저를 호출해야 하고, 궁극적으로 지정생상자를 호출해야 한다.
인스턴스 메모리 생성에 대한 규칙이 존재한다.
```
7. 생성자의 상속/재정의
    - 하위클래스는 기본적으로 상위클래스 생성자를 상속하지 않고 재정의(동일한 이름을 가진 생성자 구현)가 원칙
    - 원칙 1) 상위의 지정생성자(이름 및 파라미터) 고려
    - 원칙 2) 현재단계의 저장속성을 고려해서 구현
```swift

class AClass {
    var x = 0
    
    // init() { }
}

let a = AClass()

class BClass: AClass {
    var y: Int

// [1단계] 상위 지정 생성자 고려
    // 선택 1) 지정 생성자로 재정의
    override init() {
        self.y = 0
        super.init() // x 설정
    }

    // 선택 2) 서브 클래스에서 편의 생성자로 구현
    override convenience init() {
        self.init(y: 0)
    }

    // [2단계] 현재단계의 생성자 구현
    init(y: Int) {
        self.y = y
        super.init()
    }
}

let b = BClass()

class CClass: BClass {
    var z: Int

    override init() {
        self.z = 0
        super.init()
    }

    init(z: Int) {
        self.z = z
        super.init()
    }
}

// Apple Swift Document EX
class Vehicle {
    var numberOfWheels = 0

    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }

    // init() { }
}

class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

// sub-class
class Hoverboard: Vehicle {
    var color: String

    override var description: String {
        return "\(super.description) in a beautiful \(color)"
    }

    init(color: String) {
        self.color = color
        super.init()
    }
}
```
7. 1 . 예외상황
    - (실패 가능성이 없으면) 새 저장 속성이 없거나, 기본값이 설정되어 있다면 => 슈퍼클래스의 지정생성자 모두 자동 상속됨
    - (실패 가능성 존재시) 자동 상속됨. 지정 생성자를 자동으로 상속하거나, 상위 지정생성자 모두 재정의를 구현해야 함.
    - 결국, 모든 지정생성자를 상속하는 상황이 되면 편의 생성자는 자동으로 상속된다.
```swift
// 애플 공식문서의 예제
class Food {
    var name: String

    init(name: String) {
        self.name = name
    }

    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

let namedMeat = Food(name: "Bacon") // Bacon
let mysteryMeat = Food() // [Unnamed]

class RecipeIngredient: Food {
    var quantity: Int

    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }

    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }

    // convenience init 자동 상속
}

let oneMysteryItem = RecipeIngredient()
oneMysteryItem.name // [Unnamed]
oneMysteryItem.quantity // 1

let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

class ShoppingListItem: RecipeIngredient {
    var purchased = false

    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? "OK" : "X"
        return output
    }
}
```
8. 필수 생성자(Required)
    - 생성자 앞에 `required` 키워드를 붙여 사용하고, 하위 생성자는 반드시 해당 생성자를 구현해야만 한다.
    - override를 사용하지 않고 required를 이용하면 된다.
```swift
class AClass {
    var x: Int
    
    required init(x: Int) {
        self.x = x
    }
}

class BClass: ACless {
    // 구현 안하면 자동 구현됨 !
}

class CClass: AClass {
    init() {
        super.init(x: 0)
    }

    required init(x: Int) {
        super.init(x: x)
    }
}
```
9. 실패 가능 생성자(Failable Initializers)
    - 인스턴스 생성에 실패할 수도 있는 가능성이 있는 생성자
    - 실패가능 생성자를 정의하고 예외처리를 하는것이 좋음.
    - 생성자에 `?`를 붙여 정의한다.
    - 실패 가능 생성자는 실패 불가능 생성자를 호출할 수 있다.
    - 실패 불가능 생성자는 실패 가능 생성자를 호출할 수 없다.

```swift
// 예시
struct Animal {
    let species: String

    init?(species: String) {
        if species.isEmpty {
            return nil
        }
        self.species = species
    }
}

let a = Animal(species: "Bear") // 인스턴스 생성 성공
let b = Animal(species: "") // nil

// 활용
enum TemperatureUnit {
    case kelvin
    case celsius
    case fahrenheit

    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = TemperatureUnit.kelvin
        case "C":
            self = TemperatureUnit.celsius
        case "F":
            self = TemperatureUnit.fahrenheit
        default:
            return nil
        }
    }
}
```
10. 소멸자(Deinitialers)
    - `deinit` 키워드로 사용한다.
    - 인스턴스가 메모리에서 헤제되기 직전 정리가 필요한 내용을 구현하는 메서드
    - 클래스 정의시 최대 1개의 소멸자를 정의할 수 있음
    - 소멸자는 파라미터를 사용하지 않음
```swift
class AClass {
    var x = 0

    deinit {
        print("인스턴스 소멸")
    }
}

var a: AClass? = AClass()
a = nil
```
10. 1 . 소멸자 작동 방식
    - Swift는 클래스의 인스턴스를 자동 참조 계산(ARC) 방식을 통해 메모리를 관리한다.
    - 일반적인 경우에는 메모리에서 해제될 때 수동으로 관리를 수행할 필요가 없다.
    - 단, 특별한 작업을 수행중인 경우 추가 정리가 필요할 수 있음
    - 상속이 있는 경우 상위클래스 소멸자는 해당 하위클래스에 의해 상속됨
    - 상위클래스 소멸자는 하위클래스 소멸자의 실행이 끝날 때 자동으로 호출됨
    - 상위클래스 소멸자는 하위클래스가 자체적인 소멸자를 제공하지 않아도 항상 호출됨
    
## 보충
1. 지정 생성자의 역할은 모든 저장속성의 초기값 셋팅이다.
2. 그런데 편의 생성자는 지정 생성자를 "무조건" 호출하고, 편의 생성자는 지정 생성자에서 모든 저장 속성값을 셋팅하니, 편의 생성자 자체로는 아무것도 할 수가 없다.
3. 그래서 일반적으로 편의 생성자는 모든 속성을 초기화하지 않을 때 구현하되, 편의 생성자가 지정 생성자를 호출하니, 내부에서는 모든 저장속성 값을 결국 지정 생성자가 셋팅한다.