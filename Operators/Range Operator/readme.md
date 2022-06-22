# 범위 연산자(Range Operator)
제한된 숫자의 범위를 표시하기 위한 연산자. 자체가 특별한 타입을 의미한다.
- `1...10` (정수 1 ~ 10)

## 규칙 및 활용
내림차순 형식으로 표기할 수 없다. (내림차순으로 변환은 가능함)<br>
실수 형식의 범위도 가능(거의 사용하지 않음)<br><br>
주로 Switch에서 패턴 매칭에 사용됨.<br>
for문과 주로 함께 사용(정수일 때)<br>
배열의 서브스크립트 문법과 함께 사용함.

## 폐쇄 범위 연산자(Closed Range Operator)
```swift
let range = 1...10 // ClosedRange<Int>

let range2 = 1... // PartialRangeForm<Int>

let range3 = ...10 // PartialRangeThrough<Int>
```
해당 값을 포함하면서 범위를 정의한다. 한 방향은 열리도록 정의하는 것도 가능하다.<br>
- One-Sided Ranges

## 반폐쇄 범위 연산자(Half-Open Range Operator)
```swift
let rangeH = 1..<10 // Range<Int>

let rangeH2 = ..<10 // PartialRangeUpTo<Int>
```
앞의 값은 포함, 뒤의 값을 포함하지 않고 범위를 정의한다. 위와 마찬가지로 한 방향은 열리도록 정의하는 것이 가능하다.
- One-Sided Ranges

## 범위 연산자의 활용
! <추가 예정>