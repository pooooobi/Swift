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