# 제네릭(Generics)
1. 제네릭, 왜 필요할까 ?
    - 만약 변수를 서로 바꾸는 swap 함수가 존재한다고 하자.
    - 변수의 타입별로 함수를 만들어 줘야 하는 불편함이 있다.
        - ex) Int, Stirng, Double... 별로 함수를 만들어야 함.
    - 따라서, 제네릭의 개념이 없다면 함수를 모든 경우마다 다시 정의해야 한다.
```swift
// 기존 문법
var num1 = 10
var num2 = 20

// Double, Stirng 적용 가능
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temp = a
    a = b
    b = temp
}

func swapTwoDouble(_ a: inout Double, _ b: inout Double) {
    let temp = a
    a = b
    b = temp
}
// 형식에 따라 함수의 개수가 증가한다.

swapTwoInts(&num1, &num2)
```

2. 제네릭 문법
    - 형식에 관계없이 한번의 구현으로 모든 타입을 처리하며, 타입에 유연한 함수 작성 가능
        - 유지보수, 재사용성 증가
    - 타입 파라미터는 함수 내부에서 파라미터 형식이나 리턴형으로 사용됨(함수 바디에서도 사용 가능)
    - 보통 `T`를 사용하지만, 다른 이름을 사용하는 것도 문제가 없음.
        - 형식 이름이기 때문에 UpperCamelCase로 선언
        - 2개 이상 선언 가능
    - 제네릭은 타입에 관계없이 하나의 정의로 모든 타입의 자료형을 처리할 수 있는 문법
    - 제네릭 함수, 제네릭 클래스/구조체..
    - 일반 함수와 비교하면 작성해야 하는 코드의 양이 감소
3. 제네릭 함수의 정의
    - 타입 파라미터 `<T>`는 함수의 내부에서 파라미터의 타입이나 리턴형으로 사용됨
        - 관습적으로 Type의 약자인 대문자 T를 사용하지만 다른 문자를 사용해도 됨
    - 1 ) 타입 파라미터의 지정 : 함수의 이름 마지막에 < > 를 쓰고 안에 타입 파라미터 작성
    - 2 ) 타입 파라미터의 사용 : 본래 타입의 사용하는 위치에서 타입이 필요한 곳에 타입 파라미터 사용
        - 실제 함수 호출시 실제 타입으로 치환됨
```swift
// 타입 T만 사용가능. 즉, String, String은 가능하나 String, Int는 불가능하다.
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}
```