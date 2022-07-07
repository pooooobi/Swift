# 열거형(Enumeration)
타입을 한정된 사례 안에서 정의할 수 있는 타입
```swift
// 요일
enum Weekday {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
}

// 동서남북
enum Orientation {
    case north, south, east, west
}
```

## 언제 열거형을 사용할까?
1. 한정된 사례 안에서 정의할 수 있을 때
    - 요일
    - 동, 서, 남, 북
    - 좌로 정렬, 우로 정렬 등..
    - 초, 중, 고, 대학교, 대학원..

열거형을 사용하면 코드의 가독성과 안정성이 높아진다. 즉, 명확한 분기처리가 가능하다 !

## 열거형 타입
열거형은 타입이다. 코드를 보면 직접 선언하고 접근 연선자로 접근한다.
```swift
var today: Weekday = Weekday.thursday
today = .friday

// 만약 ~ 요일일 때 특정 처리를 할 경우
if today == .friday {
    // 코드
}

// switch 문으로 분기처리가 가능하다
switch today {
    case .monday:
        print("월요일")
    case .tuesday:
        print("화요일")
    // 생략
}
```

## 열거형의 원시값(Raw Values)과 연관값(Associated Values)
열거형의 원시값은 매칭되는 기본값(정수, 문자열)을 정해 열거형을 쉽게 활용할 수 있다.
```swift
enum Alignment: Int {
    case left = 0
    case center // 1
    case right // 2
    // 굳이 left = 0 처럼 안해도 다음 숫자는 자동으로 +1 되어 들어간다. 쉽게 생각해서 맨 처음 값이 default, 그 다음부터는 +1이 된다.
}

enum Alignment1: String {
    case left = "L"
    case center = "C"
    case right = "R"
}

let align = Alignment(rawValue: 0) // instance 생성시 Optional type으로 return
let leftValue = Alignment.center.rawValue

// 문자열 방식도 가능하나 잘 사용하진 않음
Alignment1(rawValue: "C")
let centerValue = Alignment1.center.rawValue
```
원시값의 활용 : 숫자 혹은 문자열과 매칭시켜 자유롭게 활용함
```swift
enum RpsGame: Int {
    case rock
    case paper
    case scissors
}

// 실제 사용하는건..
RpsGame(rawValue: 0)! // 오류 가능성이 없어 강제할당
RpsGame(rawValue: 1)

// 논리적으로 nil이 될 수 없다면
let number = Int.random(in: 0...100) % 3
print(RpsGame(rawValue: number)!)

// 옵셔널 값을 벗겨 사용
if let r = RpsGame(rawValue: 0) {
    print(r)
}

enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

let planet = Planet(rawValue: 2)!

let num = planet.rawValue
print(num) // 2
```
열거형의 연관값 : 구체적인 추가 정보를 저장하기 위해 사용함
```swift
enum Computer {
    case cpu(core: Int, ghz: Double)
    case ram(Int, String)
    case hardDisk(gb: Int)
}

// 각 케이스별 특징이 있고, 그걸 저장하고 활용해야 할 때
// 개별 케이스마다 저장할 형식을 정의(튜플의 형태)

let myChip1 = Computer.cpu(core: 8, ghz: 3.5)
let myChip2 = Computer.cpu(core: 16, ghz: 4.0)

let myChip3 = Computer.ram(16, "DRAM")
let myChip4 = Computer.ram(4, "SRAM")
let myChip5 = Computer.ram(32, "DRAM")

let myChip6 = Computer.hardDisk(gb: 128)
let myChip7 = Computer.hardDisk(gb: 512)

// 원시값을 활용한다면? 각 특징별로 저장할 수 없음.
```
## 원시값과 연관값의 차이 ?
1. 자료형 선언 방식 : 선언 위치가 다름
2. 선언 형식
    - 원시값 : 2가지중 1가지 선택
    - 연관값 : 튜플의 형태로 제한 없음
3. 값의 저장 시점
    - 원시값 : 선언시점
    - 연관값 : 새로운 열거형을 생성할 때
4. 서로 베타적이다. 원시값과 연관값을 함께 사용할 수 없다.

## 연관값의 활용
```swift
var chip = Computer.cpu(core: 8, ghz: 2.0)

switch chip {
    case .cpu(core: 8, ghz: 3.1):
        print("8 Core 3.1 GHZ CPU")
    case .cpu(core: 8, ghz: 2.6):
        print("8 Core 2.6 GHZ CPU")
    case .ram(32, _):
        print("32GB RAM")
    default:
        print("관심이 없는 부품입니다.")
}

switch chip {
    case let .cpu(a, b):
        print("CPU \(a) Core, \(b) GHz")
    case let .ram(a, _):
        print("\(a) GB RAM")
    case let .hardDisk(a)
        print("\(a) GB HardDisk")
}
```

## 열거형을 통해 알아보는 옵셔널(Optional)
Optional은 내부적으로 enum으로 둘러 쌓여있는데,
```swift
// Generic
enum Optional<Wrapped> {
    case some(Wrapped)
    case none
}
```
`.some`은 연관값을 의미하며 구체적인 정보를, `.none`은 값이 없음을 나타내고 nil을 나타낸다.<br>
`.none == nil` 의 의미를 가지고, 명시적인 열거형으로 표현했으나 일반적으로는 nil 키워드를 사용함.

## 열거형과 스위치문
열거형에 대한 구체적인 처리는 스위치문과 함께 쓸 때 사용성이 높다.<br>
OAuth 2.0 기반으로 되어있는 소셜 로그인을 예로 들어보자.
```swift
enum LoginProvider: String {
    case email
    case facebook
    case naver
    case google
    case kakao
}

let userLogin = LoginProvider.facebook

switch userLogin {
    case .email:
        print("이메일 로그인")
    case .facebook:
        print("페이스북 로그인")
    case .naver:
        print("네이버 로그인")
    case .google:
        print("구글 로그인")
    case .kakao:
        print("카카오 로그인")
}
```
열거형은 스위치문으로 많이 활용되나 소수의 작은 사례만 스위치를 사용하지 않는다. 거의 스위치를 쓴다고 보면 된다 !<br>
표현식에 대한 분기처리에 최적화 되어있다. `switch`문을 안 쓸 이유가 없다.

## 옵셔널 열거형 (Enumeration Case Pattern)
```swift
enum SomeEnum {
    case left
    case right
}

let x: SomeEnum? = .left

switch x {
    case .some(let value):
        switch value {
            case .left:
                print("LEFT")
            case .right:
                print("RIGHT")
        }
    case .none:
        print("NONE")
}
```
잘 살펴보면 SomeEnum의 `Optional`로 선언된 x가 switch 안에 담겨 `.some`과 `.none`으로 되어있는 것을 볼 수 있다.<br>
위에서 열거형을 통해 알아보는 옵셔널 을 살펴보면 제너릭 선언에서 사용하는 형식임을 알 수 있다.

## 열거형에 연관값이 있는 경우 (Enumeration Case Pattern)
1. 연관값이 있는 열거형의 활용 : 열거형 case 패턴
2. 구체적 정보를 변수에 바인딩 하는 패턴임.
3. 열거형 case 패턴
    - `case Enum.case(let 변수명)`
    - `case let Enum.case(변수명)`
4. 이외에도 switch, if, guard, for-in, while과 같은 반복문에서도 활용 가능하다.
```swift
enum Computer {
    case cpu(core: Int, ghz: Double)
    case ram(Int, String)
    case hardDisk(gb: Int)
}

switch chip {
    case Computer.hardDisk(gb: let gB):
        print("\(gB) GB 하드 디스크")
    default:
        break
}
```
위와 같이 사용한다면 hardDisk에 gb가 `let gB`가 되어 스위치문 안에서 자유롭게 나타낼 수 있게 된다.<br>
만약 특정 케이스라면?
```swift
if case Computer.hardDisk(gb: let gB) = chip {
    print("\(gB) GB 하드 디스크")
}
```
만약 배열로 되어있다면?
```swift
let chiplists: [Computer] = [
    .cpu(core: 4, ghz: 3.0),
    .cpu(core: 8, ghz: 3.5),
    .ram(16, "SRAM"),
    .ram(32, "DRAM"),
    .cpu(core: 8, ghz: 3.5),
    .hardDisk(gb: 500),
    .hardDisk(gb: 256)
]

for case let .cpu(core: c, ghz: h) in chiplists {
    print("CPU 칩 : \(c) CORE, \(h) GHz")
}
```
`case let .cpu(core: c, ghz: h)`의 의미는 .cpu만 뽑아 core는 c 변수로, ghz는 h 변수로 담는다는 의미다.<br>
옵셔널일 경우에는...
```swift
let arrays: [Int?] = [nil, 2, 3, nil, 5]

for case .some(let number) in arrays {
    print("Found \(number)")
}
```

## 옵셔널 패턴(Optional Pattern)
옵셔널 타입에서 열거형 케이스 패턴을 더 간소화한 옵셔널 패턴<br>
열거형 내부에 연관값을 사용시 -> 열거형 케이스 패턴, 옵셔널 패턴
```swift
let a: Int? = 1

// 열거형 케이스 패턴
switch a {
    case .some(let z):
        print(z)
    case .none:
        print("nil")
}

// 옵셔널 패턴
switch a {
    case let z?:
        print(z)
    case nil: // .none도 가능
        print("nil")
}
```
옵셔널 패턴의 사례
```swift
let num: Int? = 7 // Optional(7)

// 열거형 케이스
switch num {
    case .some(let x):
        print(x)
    case .none:
        break
}

// 옵셔널
switch num {
    case let x?:
        print(x)
    case .none:
        break
}

// if문 활용하 가능
if case .some(let x) = num {
    print(x)
}

if case let x? = num {
    print(x)
}
```
for(배열 활용)
```swift
let arr: [Int?] = [nil, 2, 3, nil, 5]

// 열거형 케이스
for case .some(let number) in arr {
    print("Found \(number)")
}

// 옵셔널 패턴
for case let number? in arr {
    print("Found \(number)")
}
```

## @unknown ?
열거형의 케이스가 늘어난다면 항상 올바른 처리를 할까?
```swift
enum LoginProvider: String {
    case email
    case facebook
    case naver
    case google
    case kakao
}

let userLogin = LoginProvider.email

// ... switch문 생략

// default 블럭을 추가하는 것 만으로 안전해 지는가?

switch userLogin {
    case .email:
        print("이메일 로그인")
    case .facebook:
        print("페이스북 로그인")
    case .naver:
        print("네이버 로그인")
    case .google:
        print("구글 로그인")
    case .kakao:
        print("카카오 로그인")
    @unknown default:
        print("이외의 모든 것")
}
```
@unknown Attribute를 활용하면 아래와 같다.
```
switch에서 모든 열거형을 다루지 않을 때 유용함.
"Switch must be exhatsive"로 알려준다.
```