# 고차함수(Higher-order Function)
- 고차함수란 ?
    - 함수를 파라미터로 사용하거나, 함수 실행의 결과를 함수로 리턴하는 함수를 뜻한다.
    - map, filter, reduce (기본 고차함수 3가지) / forEach, compactMap, flatMap 총 6가지를 다룬다.
    - Sequence, Collection 프로토콜을 따르는 컬렉션(배열, 딕셔너리, 세트 등)에 기본적으로 구현되어 있다.
        - Optional에도 구현되어 있음 !

## map Function
- 기존 배열등의 각 아이템을 새롭게 매핑하여 새로운 배열을 리턴한다.
```swift
let numbers = [1, 2, 3, 4, 5]

var newNumbers = numbers.map { (num) in
    return "숫자 : \(num)"
}

print(newNumbers) // ["숫지 : 1", "숫자 : 2", ..., "숫자 : 5"]
```

## filter Function
- 기존 배열등의 각 아이템을 조건을 확인후, 참을 만족하는 아이템을 걸러내서 새로운 배열을 리턴한다.
```swift
// 문자열 "B"를 포함하는 아이템 가져오기
let names = ["Apple", "Black", "Circle", "Dream", "Blue"]

var newNames = names.filter { (name) -> Bool in
    return name.contains("B")
}

print(newNames) // ["Black", "Blue"]

// 짝수 아이템 가져오기
let array = [1, 2, 3, 4, 5, 6, 7, 8]

var evenNumbersArray = array.filter { num in
    return num % 2 == 0
}

print(evenNumbersArray) // [2, 4, 6, 8]

// 아규먼트 이름 축약
evenNumbersArray = array.filter { $0 % 2 == 0 }

// 필터 2회 적용
// 짝수이면서 5보다 작은 숫자
evenNumbersArray = array.filter { $0 % 2 == 0 }.filter { $0 < 5 }
```

## reduce Function
- 기존 배열 등의 각 아이템을 결합하여 마지막 결과값을 리턴한다. (초기값 제공 필요)
```swift
var numbersArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// 예시
// reduce() 에서 () 안에 있는 값은 초기값이다. a에 할당된다.
// 최초 a + b를 통해 1이 되면 () 안에 값이 1이 되고, 지속 증가하게 된다.
// 결론적으로 1~10을 모두 더한 숫자가 리턴된다.
numbersArray.reduce(0) { a, b in 
    return a + b
}
 
```

## map, filter, reduce의 활용
```swift
// 1~10 배열에서 홀수만 제곱하여 그 숫자를 모두 더한 값은?
var numbersArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

var result = numbersArray.filter { $0 % 2 != 0 }
                         .map { $0 * $0 }
                         .reduce(0) { $0 + $1 }

// 1, 9, 25, 49, 81 => 165
print(result) // 165
```

## forEach Function
- foreach : 각각의
- 기존 배열 등의 각 아이템을 활용하여 특정 작업을 실행한다.
```swift
let immutableArray = [1, 2, 3, 4, 5]

// 배열의 아이템을 각각 프린트함
immutableArray.forEach { num in
    print(num)
}

// 축약
immutableArray.forEach { print("숫자 : \($0)") }
```

## compactMap Function
- 기존 배열 등의 각 아이템을 새롭게 매핑하여 변형하되, 옵셔널 요소를 제거하고 새로운 배열을 리턴한다.
- 자동으로 옵셔널 형식을 제거한다 !! (자동으로 옵셔널 바인딩의 기능이 내장되어 있다)
```swift
// 예시 1
let stringArray: [String?] = ["A", nil, "B", nil, "C"]

var newStringArray = stringArray.compactMap { $0 } // ["A", "B", "C"]
print(newStringArray)

// 예시 2(filter로도 가능)
let numbers = [-2, -1, 0, 1, 2]

var positiveNumbers = numbers.compactMap { $0 >= 0 ? $0 : nil}
print(positiveNumbers)

// compactMap의 구현
newStringArray = stringArray.filter { $0 != nil }.map { $0! }
```

## flatMap Function
- 중첩된 배열의 각 배열을 새롭게 매핑하여 내부 중첩된 배열을 제거하고 리턴한다.
```swift
// 예시 1
var nestedArray = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
nestedArray.flatMap { $0 }

// 예시 2
var newNestedArray = [[1, 2, 3], [4, 5, 6], [7, 8, 9]], [[10, 11], [12, 13, 14]]
var numbersArray = newNestedArray.flatMap { $0 }.flatMap { $0 } // 2회 사용으로 완전 제거
```