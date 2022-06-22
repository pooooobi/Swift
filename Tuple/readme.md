# 튜플(Tuples)
여러가지로 이루어진 연관된 데이터를 저장하는 방법.<br>
원하는 연관된 데이터의 조합으로 어떤 형태든 만들 수 있는 타입.
- 단, 변수 선언과 동시에 해당 데이터의 종류와 개수는 정해지므로 추가 및 삭제가 불가능하다.

## 튜플의 사용 방법
```swift
let twoDatas: (Int, Int) = (1, 2)
type(of: twoDatas) // (Int, Int).Type

let twoValues = (1, 2)
type(of: twoValues)

var threeValues = ("홍길동", 20, "서울")
type(of: threeValues) // (String, Int, String).Type
```
이와 같은 방식으로 사용한다.

## 튜플의 데이터 접근 방법
`.숫자(데이터의 n번째)` 의 방법으로 접근할 수 있다.<br>
위의 예시에 `twoDatas.0`을 입력한다면 `1`이 반환된다.

## 튜플에 이름을 새기는 방법(Named Tuple)
```swift
let iOS = (language: "Swift", version: "5")
```
위와 같은 코드를 접근하려면 `iOS.0`, `iOS.1`도 있지만, 이름을 명시할 경우 `iOS.language`, `iOS.version`과 같이 호출이 가능해진다.

## 튜플의 분해(Decomposition)
```swift
let (first, second, third) = (5, 6, 7)
first // 5
second // 6
third // 7
```
튜플의 데이터 묶음을 각 한개씩 분해하여 상수나 변수에 저장가능하다.<br>
즉, 튜플의 각 요소를 각각 상수/변수화 가능(바인딩)하게 하여 데이트를 분해해서 활용할 수 있게 된다.

## 튜플의 값의 비교
```swift
(1, "zebra") < (2, "apple") // true
(3, "apple") < (3, "bird") // true
(4, "dog") == (4, "dog") // true
```
위와 같은 방법으로 비교가 가능하나, Bool 값은 비교할 수 없다.

## 튜플의 매칭(Matching)
```swift
let iOS = (language: "Swift", version: "5")

switch iOS {
    case("Swift", "5"):
        print("스위프트 버전 5 입니다.")
    case("Swift", "4"):
        print("스위프트 버전 4 입니다.")
    default:
        break
}
```
스위프트의 switch는 튜플 매칭을 지원한다.<br>
코드를 단순한 형태로 표현할 수 있다.

## 튜플의 활용
```swift
// 튜플의 바인딩
var coordinate = (0, 5) // 좌표계

switch coordinate {
    case (let distance, 0), (0, let distance):
        print("X 또는 Y축 위에 위치하며, \(distance) 만큼 거리가 떨어져 있음.")
    default:
        print("축 위에 있지 않음.")
}

// 튜플의 where절 활용
coordinate = (5, 0)

switch coordinate {
    case (let x, let y) where x == y:
        print("(\(x), \(y))의 좌표는 y = x 1차함수 그래프 위에 있다.")
    case let (x, y) where x == -y:
        print("(\(x), \(y))의 좌표는 y = -x 1차함수 그래프 위에 있다.")
    case let (x, y):
        print("(\(x), \(y))의 좌표는 y = x, y = -x 그래프가 아닌 임의의 지점에 있다.")
}
```