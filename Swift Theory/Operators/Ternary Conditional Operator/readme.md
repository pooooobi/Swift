# 삼항 연산자(Ternary Conditional Operator)
3개의 항을 토대로 값을 도출하는 방법.<br>
`조건 ? 참의 값 : 거짓의 값`의 형태로 사용된다.<br>
우리가 주로 사용하는 if문과 연관되어 있다.

## 사용 예시
```swift
// 예시 1
var a = 10

// if
if a > 0 {
    print("1")
} else {
    print("2")
}

// 3항 연산자
a > 0 ? print("1") : print("2")

// 예시 2
var name = a > 0 ? "스티브" : "팀쿡" // 3항 연산자

// if
if a > 0 {
    name = "스티브"
} else {
    name = "팀쿡"
}
```
조건에 따라 선택이 두가지인 경우 삼항연산자를 떠올리자.