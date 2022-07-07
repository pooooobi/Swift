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