# 패턴 매칭 연산자(Pattern Matching Operator)
`a...b ~= 변수`의 형태로 사용되며, 오른쪽에 있는 표현식이 왼쪽의 범위에 표함되는지에 따라 true 혹은 false를 반환한다.
```swift
var age = 20

1...9 ~= age // false
10...19 ~= age // false
20...29 ~= age // true
// 이하 생략
```

## 패턴 매칭 연산자의 활용
!<추가 예정>