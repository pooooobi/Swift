# 함수(Function)
어떤 기능을 하는 코드 모음이며, 입력과 출력이 있을 수 있다.<br>
`func [functionName]([Arguments]){ }`의 형태로 사용한다.

## 함수는 왜 사용할까 ?
```text
1. 반복되는 동작을 단순화하여 재사용 할 수 있다.
2. 코드를 논리적 단위로 구분할 수 있다.
3. 코드 길이가 긴 것을 단순화하여 사용할 수 있다.
4. 미리 함수를 만들어 놓으면, 개발자는 사용만 하면 된다.
   * Spring 에서 Service를 만들어놓고 Controller에서 사용하고 결과값을 리턴하는 느낌이라 생각하면 편하다.
```

## 함수의 형태
함수에 인수(Arguments)가 있는 경우는 아래와 같다.
```swift
func sayByName(name: String) {
    print("안녕하세요. \(name)님")
}

sayByName(name: "Steve")
// OUT: 안녕하세요. Steve님

var name = "Tom"

sayByName(name: name)
// OUT: 안녕하세요. Tom님
```
함수가 결과값을 리턴하는 경우(아웃풋이 있는 경우)는 아래와 같다.
```swift
func sayHello() -> String {
    return "안녕하세요 !"
}

sayHello() // 안녕하세요 !

print(sayHello() + " Steve 님")
// OUT: 안녕하세요 ! Steve 님
```
파라미터가 있고, 결과값을 리턴하는 경우는 아래와 같다. (위 두 내용 포함되는 경우)
```swift
func plusFunction(a: Int, b: Int) -> Int {
    let c = a + b
    return c
}

plusFunction(a: 3, b: 4) // return 7
```
void(리턴이 없는 경우)는 아래와 같다.
```swift
func sayHello() {
    print("Hello !")
}

sayHello()
// OUT: Hello !
```