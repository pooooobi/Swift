## 문자열 중에서 한글자를 랜덤으로 뽑아내는 함수
```swift
import UIKit

func randomString(_ characters: String) -> String {
    return String(characters.randomElement()!)
}

randomString("랜덤문자열")
```
`String(변수명.randomElement()!)` -> 랜덤 하나의 문자열 뽑아냄.<br>
Declaration : `func randomElement() -> Character?`

## 소수 판별
```swift
import UIKit

func primeNumber(_ number: Int) {
    for i in 2 ..< number {
        if number % i == 0 {
            print("소수가 아님")
            return
        }
    }
    print("소수임")
}

primeNumber(97) // 소수
primeNumber(98) // 소수 X
```

## 팩토리얼 문제
```swift
import UIKit

func factorial(_ number: Int) -> Int {
    var sum = 1
    for i in 1...number {
        sum *= i
    }
    return sum
}

factorial(5) // 120
factorial(4) // 24
```
재귀함수의 방식으로도 구현 가능하나 stack overflow 현상 무조건 주의 !!