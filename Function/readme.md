# 함수(Function)
어떤 기능을 하는 코드 모음이며, 입력과 출력이 있을 수 있다.<br>
`func [functionName]([Parameters]){ }`의 형태로 사용한다.

## 함수는 왜 사용할까 ?
```text
1. 반복되는 동작을 단순화하여 재사용 할 수 있다.
2. 코드를 논리적 단위로 구분할 수 있다.
3. 코드 길이가 긴 것을 단순화하여 사용할 수 있다.
4. 미리 함수를 만들어 놓으면, 개발자는 사용만 하면 된다.
   * Spring 에서 Service를 만들어놓고 Controller에서 사용하고 결과값을 리턴하는 느낌이라 생각하면 편하다.
```

## 함수의 형태
함수에 파라미터가 있는 경우는 아래와 같다.
```swift
func sayByName(name: String) {
    print("안녕하세요. \(name)님")
}

sayByName(name: "Steve") // "Steve" -> Arguments
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

## 함수의 파라미터(Parameter), 아규먼트(Argument)
파라미터는 함수를 정의할 때 정의에 입력값으로 사용되는 변수를 뜻한다.<br>
아규먼트는 함수를 호출할 때, 함수가 필요한 파라미터의 타입과 일치하는 실제 값을 뜻한다.
```swift
// Parameter

func printName(name: String) {
    print("이름은 \(name) 입니다.")
}

printName(name: "Steve") // Steve -> Argument
```

## 아규먼트 레이블(Argument Label)
`func [functionName](Argument Label [Parameter]: Parameter Type)`으로 이해할 수 있다.<br>
사용하려면 `functionName(Argument Label: Value)`로 사용하면 된다.
```swift
func printName(first name: String) {
    print("이름은 \(name) 입니다.")
}

// printName(name: "Steve") -> 오류 발생
printName(first: "Steve")
```
위 내용에서 파라미터를 확인하면 `name` 앞에 `first`가 붙는다. 해당 함수에서는 name으로 사용하지만, 외부에서 사용할 때 `printName(first: "Steve")`의 형식으로 사용하게 된다.<br>
일반적으로 함수를 사용할 때, 명확한 의사전달을 위해 어떤 것을 요구하는지, 어떤 것을 의미하는지 명확하게 하기 위해 아규먼트 레이블을 사용한다.
```swift
// Argument Label을 사용했을 때의 이점

func whatFunction(whatsYourName a: String, whatsYourAge b: Int) {
    print("너의 이름은 \(a) 이고, 나이는 \(b)살 이다.")
}

whatFunction(whatsYourName: "Steve", whatsYourAge: 25)
// 어떤것을 요구하는지 좀 더 명확해졌다
```
아규먼트 레이블을 생략하여 사용할 수 있다. (와일드카드를 사용하는 방법)
```swift
func addPrintFunction(_ firstNum: Int, _ secondNum: Int) {
    print(firstNum + secondNum)
}

addPrintFunction(1, 2)
// 위와는 다르게 어떤것을 요구하는지는 함수를 확인해야 하지만, 깔끔해 보이기는 한다
```

## 가변 파라미터(Variadic Parameters)
- 함수의 파라미터에 정해지지 않은 여러 값을 넣을 수 있다.<br>
- 아규먼트(Argument)는 배열의 형태로 전달된다.<br>
- 가변 파라미터는 개별 함수마다 하나씩만 선언할 수 있으며, 순서는 관계없다.<br>
- 가변 파라미터는 기본값을 가질 수 없다.
```swift
func arithmeticAverage(_ numbers: Double...) -> Double {
    var total = 0.0

    for n in numbers {
        total += n
    }

    return total / Double(numbers.count) // numbers.count는 Int이므로 Double 계산을 위해 Double() 사용
}

arithmeticAverage(1.5, 2.5, 3.5, 4.5) // 더 추가 가능함.
```
위 코드를 잘 살펴보면 함수 선언 시 파라미터에 `...`가 붙은 것을 알 수 있다. 저렇게 사용한다.

## 파라미터에 기본값을 넣기(Parameter's value in default value)
```swift
func numFunction(num1: Int, num2: Int = 5) -> Int {
    return num1 + num2
}

numFunction(num1: 3)
numFunction(num1: 3, num2: 7)
```
아규먼트 값이 필요없는 경우도 있다.<br>
실제 애플이 미리 만든 함수에는 기본값이 거의 들어가있는 경우가 많다.<br>
ex) `print(items: Any..., separator: String, terminator: String)`