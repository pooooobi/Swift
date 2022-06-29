# 반복문(Loops)
`for`, `while`, `repeat-while` 세가지의 반복문이 있으며, `while`, `repeat-while`을 합쳐 `while` 반복문이라고 한다.

## for문
`for INDEX in RANGE`의 형태로 사용한다.
```swift
// for의 예시
for index in 1...5 { // index가 1부터 5까지 증가하며 5가되면 마지막으로 실행되고 종료됨.
    print("index의 값 : \(index)")
}

// 활용방법 2
var number = 10

for i in 1...number {
    print(i) // 혹은 print("\(i)")
}
```

## 와일드 카드 패턴
와일드 카드 패턴(`_`, 언더바)은 스위프트에서 생략의 의미로 사용된다.
```swift
// 예시 1
for _ in 0...10 { 
    // 만약 _ 대신 i를 넣는다면, i를 내부에서 사용하지 않기 때문에 '_'로 교체를 권장하는 메세지가 나타난다.
    print("hello")
}

// 예시 2
let _ = "문자열"
// 밑에서 사용되지 않기 때문에 사라져도 상관없는 것.

// 예시 3
(1...10).reversed()
// 10, 9, 8, 7, ..., 1 -> 숫자의 역전 .reversed()
// ReversedCollection<ClosedRange<Int>>
```

## 배열 등 컬렉션 타입에서의 사용
```swift
let list = ["Swift", "Programming", "Language"]

for str in list {
    print(str)
}
// 출력 : Swift -> Programming -> Language
```

## 문자열에서의 사용
문자열에서 각 문자를 차례 차례 하나씩 뽑아 중괄호 안에서 사용한다.
```swift
for chr in "Hello" {
    print(chr) // 혹은 print(chr, terminator: " ") -> 다음줄로 넘어가지 말고 한칸 띄운다.
}
```

## 특정한 함수를 이용하여 활용
```swift
// 역순
for number in (1...5).reversed() {
    print(number)
}
// 출력 : 5 -> 4 -> 3 -> 2 -> 1

// 홀수 혹은 짝수로
for number in stride(from: 1, to: 15, by: 2) {
    print(number)
}
// 출력 1 -> 3 -> 5 ... -> 13
// 마지막은 포함하지 않음.
// 아래에서 자세하게 설명함.
```

## stride
`stride` : 성큼성큼 걷다.<br>
`Stride(from: Strideable, to: Strideable, by: Comparable & SignedNumeric)`
```swift
let range = stride(from: 1, to: 15, by: 2) //  StrideTo<Int>
print(range)
// 1, 3, 5, 7, 9, 11, 13

for i in range {
    print(i)
}

let range1 = stride(from: 1, through: 15, by: 2) // StrideThrough<Int>
print(range1)
// 1, 3, 5, 7, 9, 11, 13, 15

for i in range1 {
    print(i)
}

let range2 = stride(from: 10, through: 2, by: -2) //   StrideThrough<Int>
print(range2)
// 10, 8, 6, 4, 2


for i in range2 {
    print(i)
}
```
`through`는 해당 숫자 까지를 뜻한다.

## while문
`while 조건 { }` 의 형태로 사용한다.<br>
조건은 상황에 맞게 변화되어야 하며, `무한 반복`되지 않도록 유의해야 한다.
```swift
var sum = 0
var num = 1

while num <= 50 {
    sum += num
    num += 1
}

print("총 합의 출력: ", sum)
```

## repeat-while문
`repeat { } while 조건`의 형태로 사용되며, 한번 실행 후 조건을 판단하여 실행한다.<br>
루프를 통과하는 각 패스의 끝 부분에서 조건을 평가한다.<br>
다른 언어에서는 do-while문으로 부른다.
```swift
var i = 1

repeat {
    print("\(3) * \(i) = \(3*i)")
    i += 1
} while i <= 9
```

## while? repeat-while?
둘의 가장 큰 차이점은 코드를 실행하고 조건을 비교하느냐, 혹은 조건부터 비교하고 코드를 실행하느냐의 차이다.<br>
`while`은 조건부터 확인하고 내부 코드를 실행하는 반면, `repeat-while`은 코드부터 실행하고 조건을 비교한다.
```swift
var number = 5
var sumOfNum = 0

while number < 5 {
    sumOfNum += number
    number += 1
}

number // 5
sumOfNum // 0

repeat {
    sumOfNum += number
    number += 1
} while number < 5

number // 6
sumOfNum // 5
```

## 제어전송문(Control Transfer Statement)
제어전송문에는 `continue`, `break`가 있다.
```swift
// contiune
for num in 1...20 {
    if num % 2 == 0 {
        continue // 1, 3, 5, ..., 19 까지 출력됨.
    }
    print(num)
}

// break
for num in 1...20 {
    if num % 2 == 0 {
        break
    }
    print(num) // 1만 출력되고 break로 종료됨.
}
```
`continue`는 가장 인접한 반복문으로 돌아가기 때문에, 잘 살펴볼 필요가 있다.<br>
코드의 라인수가 많을 때, 잘 확인해야 한다 !!

## 레이블이 새겨진 문장(Labeled Statements)
레이블이 새겨진 문장에 continue, break를 사용할 수 있다.
```swift
// 실행해보면 이해가 쉽다.
OUTER: for i in 0...3 {
    print("OUTER \(i)")
    INNER: for j in 0...3 {
        if i > 1 {
            print("   j :", j)
            continue OUTER
            // break OUTER
        }
        print("   INNER \(j)")
    }
}
```