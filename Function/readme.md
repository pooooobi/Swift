# 함수(Function)
어떤 기능을 하는 코드 모음이며, 입력과 출력이 있을 수 있다.<br>
`func [functionName]([Parameters]){ }`의 형태로 사용한다.

## 함수는 왜 사용할까 ?
```text
1. 반복되는 동작을 단순화하여 재사용 할 수 있다.
2. 코드를 논리적 단위로 구분할 수 있다.
3. 코드 길이가 긴 것을 단순화하여 사용할 수 있다.
4. 미리 함수를 만들어 놓으면, 개발자는 사용만 하면 된다.
   * Spring 에서 Service를 만들어 내부 함수를 만들고 Controller에서 Service의 함수를 사용하고 결과값을 리턴하는 느낌이라 생각하면 편하다.
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

## 함수 사용시 주의점
함수 파라미터에 대한 정확한 이해가 필요하다.
```swift
func oneAddFunction(a: Int) -> Int {
    a = a + 1
    // 여기서 a는 let a: Int로 이미 선언되어 있는 것임
    return a
}
```
함수 내에서 선언한 변수의 범위(Scope)는 함수의 바디로 제한된다.
```swift
func sumFunction(a: Int, b: Int) -> Int {
    return a + b
}

// a
// b

// 위 변수는 사용 불가하다
```
return 키워드에 대한 정확한 이해가 필요하다.<br>
    * 리턴 타입이 있는 함수의 경우 : 리턴 키워드 다음의 표현식을 평가한 후 그 결과를 리턴하면서 함수를 벗어남.<br>
    * 리턴 타입이 없는 함수의 경우 : 함수의 실행을 중지하고 함수를 벗어남.
```swift
// 리턴 타입이 있는 경우
func checkNumber(_ num: Int) -> Int {
    if num >= 5 {
        return num // 반환될 경우 함수 사용 종료.
    }
    return 0
}

// 리턴 타입이 없는 경우
func numberPrint(_ num: Int) {
    if num >= 5 {
        print("숫자가 5 이상입니다.")
        return // return을 요구하지는 않지만, 쓸 경우 중지됨.
    }
    print("숫자가 5 이하입니다.")
}
```

## 함수 표기법(지칭) 및 타입의 표기
```swift
// 예시 1
func doSomething() {
    print("출력")
}

doSomething

// 예시 2
func numberPrint(n num: Int) {
    if num >= 5 {
        print("숫자가 5 이상입니다")
        return
    }
    print("숫자가 5 이하입니다.")
}

numberPrint(n: )

// 예시 3
func chooseStepFunction(backward: Bool, value: Int) -> Int {
    func stepForward(input: Int) -> Int {
        return input + 1
    }

    func stepBackward(input: Int) -> Int {
        return input - 1
    }

    if backward {
        return stepBackward(input: value)
    } else {
        return stepForward(input: value)
    }
}

chooseStepFunction(backward:value:)

// 예시 4
func addPrintFunction(_ firstNum: Int, _ secondNum: Int) {
    print(firstNum + secondNum)
}

addPrintFunction(_:_:)
```
함수의 표기
1. 파라미터가 없는 경우 -> ()를 삭제한다.
    - ex) `doSomething`
2. 아규먼트 레이블이 있는 경우, 아규먼트 레이블까지 함수 이름으로 본다.
    - ex) `numberPrint(n: )` -> numberPrint n 함수
3. 파라미터가 여러개인 경우, 콤마 없이 아규먼트 이름과 콜론을 표기한다.
    - ex) `chooseStepFunction(backward:value:)`
4. 아규먼트 레이블이 생략된 경우(와일드 카드 사용)
    - ex) `addPrintFunction(_:_:)`


함수 타입의 표기
1. 변수에 정수를 저장하는 경우 타입 표기
    - ex) `var num: Int = 5`
2. 함수 타입 표기
    - ex) `var function1: (Int) -> () = numberPrint(n:)`
    - ex2) `var function2: (Int, Int) -> () = addPrintFunction(_:_:)`

## 함수의 오버로딩(overloading)
같은 함수의 이름에 여러개의 함수를 대응 시키는 것을 뜻한다.
```swift
func doSomething(value: Int) {
    print(value)
}


func doSomething(value: Double) {
    print(value)
}


func doSomething(value: String) {
    print(value)
}


func doSomething(_ value: String) {
    print(value)
}


func doSomethging(value1: String, value2: Int) {
    print(value1, value2)
}
```
위 처럼 함수의 이름을 재사용 할 수 있다.<br>
정말 모르겠다면, 자바에서 파라미터의 수에 따라 함수를 만들었던 기억을 참고하자.

## 범위(Scope)
변수는 코드에서 선언이 되어야 그 이하의 코드에서 접근할 수 있다. (전역변수는 예외)<br>
상위 스코프에서 선언된 변수와 상수에 접근 가능하나, 하위 스코프에서는 접근할 수 없다.<br>
가장 인접한 스코프에 있는 변수와 상수에 먼저 접근한다.<br><br>
쉽게 생각해서 { } 안에서만 있다고 보면 편하다. 물론 전역변수는 예외다.

## 인아웃 파라미터(inout parameter)
함수를 통해 변수를 직접 수정하고 싶은 경우는 어떻게 해야할까?<br>
함수 내 파라미터는 기본적으로 값타입이고(복사되어 전달되는 방식) 임시상수이기 때문에 변경 불가능하다.
```swift
var num1 = 1
var num2 = 2

func swap(a: Int, b: Int) {
    var temp = a
    a = b
    b = temp
}

// 오류 발생
```
하지만 함수 내에서 변수를 직접 수정하도록 하는 `inout` 키워드가 있다.<br>
`inout` -> 선언시, & -> 사용(실행)시
```swift
var num1 = 1
var num2 = 2

func swapNumbers(a: inout Int, b: inout Int) {
    var temp = a
    a = b
    b = temp
}

swapNumbers(a: &num1, b: &num2) // 사용하기 위해 앰퍼센트(&)를 꼭 사용해야 한다
```
입출력 파라미터는 내부적으로 copy-in, copy-out 메모리 모델을 사용하여 원본을 전달한다.<br>
값을 복사해서 함수 바디(내부)로 전달하고, 종료될 때 Argument로 전달한 변수에 복사된다.<br><br>
`inout` 파라미터를 사용하면서<br>
1. 상수(let)나 리터럴 전달할 수 없음
2. 파라미터의 기본값 선언을 허용하지 않음
3. 가변파라미터(여러개의 파라미터)로 선언하는 것은 불가능함