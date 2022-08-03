# 클로저(Closure)
1. 클로저는 이름이 없는(익명) 함수다.
    - 줄여서 익명 함수라고도 부른다.
2. 클로저와 함수는 기능이 동일한데, 형태가 조금 다르다.
    - 클로저 안에 함수가 있다고 생각하면 된다.
    - C언어의 Block, 파이썬의 lambda => Swift의 클로저
3. 함수의 형태와 클로저의 형태 비교
```swift
// 함수
func aFunction(str: String) -> String {
    return "Hello, \(str)"
}

// 클로저
let _ = {(str: String) -> String in
    return "Hello, \(str)"
}

let closureTypeTest = {() -> () in 
    print("클로저 타입 테스트")
}

closureTypeTest()
```
4. 스위프트는 함수를 일급 객체로 취급한다.
    - 함수를 변수에 할당할 수 있다.
    - 함수를 파라미터로 전달할 수 있다.
    - 함수에서 함수를 반환할 수 있다.
    - 결론적으로 함수도 타입이다.
```swift
func aFunction(_ param: String) -> String {
    return param + "!"
}

func aFunction2(name: String) -> String {
    return name + "?!?"
}

// 함수를 변수에 할당할 수 있음
var a: (String) -> String = aFunction1

let closureTest = { (param: String) -> String in
    return param + "!"
}

closureTest("테스트") // 테스트!
```
4. 클로저의 형태
    - 리턴형에 대한 표기를 생략
    - 파라미터의 타입 생략
        - 위 내용 모두 컴파일러가 타입 추론 가능한 경우에 사용 가능하다.
```swift
let aClosure = {(str: String) in
    return "Hello, \(str)"
}

let bClosure: (String) -> String = { (str) in
    return "Hello, \(str)"
}

let cClosure = { // 실제 형태는 let cClosure = { () -> () in print("~~~") }
    print("Closure 형태입니다.")
}

let dClosure = { str in
    return str + "!" // !가 문자열이여서 문자열 + 문자열이 되지, 정수 + 문자열이 되진 않기 때문에 String의 형태로 이미 인식중임
}
```
5. 클로저를 왜 사용할까?
    - 함수를 실행할 때 클로저 형태로 전달할때 사용
```swift
func closureFunction(closure: () -> ()) { // I/O -> Void
    print("프린트 시작")
    closure()
}

func printSwiftFunction() {// I/O -> Void
    print("프린트 종료")
}

let printSwift = { () -> () in  // I/O -> Void
    print("프린트 종료")
}

closureFunction(closure: printSwiftFunction)

closureFunction(closure: printSwift)

// 함수를 실행할 때 클로저 형태로 전달할때 사용
closureFunction(closure: { () -> () in 
    print("프린트 종료")
})
```
6. 클로저의 문법 최적화
    - 문맥상에서 파라미터와 리턴밸류 타입 추론(Type Inference)
    - 싱글 익스텐션(코드가 한줄인 경우), 리턴을 적지 않아도 됨(Implicit Return)
    - 아규먼트 이름을 축약(Shortand Arguments) => $0, $1
    - 트레일링 클로저 문법(Trailing Closure)
        - 함수의 마지막 전달인자(아규먼트)로 클로저를 전달하는 경우 소괄호를 생략
```swift
// 함수 정의
func closureParamFunction(closure: () -> Void) {
    print("시작")
    closure()
}

// 함수 실행시 클로저 형태로 전달
// 마지막 전달인자(아규먼트)로 클로저 전달되는 경우 소괄호 생략 가능

// 원래의 형태
closureParamFunction(closure: { 
    print("종료")
})

// 소괄호를 앞으로
closureParamFunction(closure: ) {
    print("종료")
}

// 아규먼트 생략(후행 클로저 문법)
closureParamFunction() {
    print("종료")
}

// 예시
func closureCaseFunction(a: Int, b: Int, closure: (Int) -> Void) {
    let c = a + b
    closure(c)
}

closureCaseFunction(a: 5, b: 2) { number in
    print("결과: \(number)")
}


// 파라미터 및 생략 등의 간소화
func performClosure(param: (String) -> Int) {
    param("Swift")
}

performClosure(param: { (str: String) in 
    return str.count
})

// 위를 아래와 같이 변경한다.
// 타입 추론
performClosure(param: { str in
    return str.count
})

// 한줄인 경우 리턴 필요없음(Implicit Return)
performClosure(param: { str in 
    str.count
})

// 아규먼트 이름 축약(Shortand Arguments)
// $0 => 1번째 파라미터, $1 => 2번째 파라미터, ..., $999 => 1000번째 파라미터, ...
performClosure(param: {
    $0.count
})

// 트레일링 클로저
performClosure() {
    $0.count
}

// 이와 같이 줄이기도 가능함
performClosure { $0.count }
```
7. 멀티플 트레일링 클로저
    - 기존 트레일링 클로저에서 여러 함수를 받아야 할 때 사용된다.
    - 트레일링 클로저보다 축약되며, Swift 5.3 이상 지원된다.
    - XCode에서 자동 지원함 !
```swift
func multipleClosure(first: () -> (), second: () -> (), third: () -> ()) {
    first()
    second()
    third()
}

// 기존
multipleClosure(first: {

}, second: {

}, third: {

})

// 멀티플 트레일링 클로저
multipleClosure {

} second: {

} third: {

}
```
8. 클로저의 캡처 현상
    - 일반적으로 함수 내에서 함수를 실행하고 값을 리턴하는게 일반적이다.
    - 근데 클로저는 저장할 필요가 있는 값을 캡처하여 값을 저장한다.
        - 값을 저장하거나 참조를 저장함
```swift
var stored = 0

let closure = { (number: Int) -> Int in
    stored += number
    return stored
}

closure(3) // 3
closure(4) // 7
closure(5) // 12

stored = 0

closure(5) // 5
```
9. escaping, autoclosure 키워드
    - @escaping
        - 원칙적으로 함수의 실행이 종료되면 파라미터로 쓰이는 클로저도 제거됨
        - @escaping 키워드는 클로저를 제거하지 않고 함수에서 탈출시킴(함수 종료 => 클로저 존재)
        - 따라서 클로저가 함수의 실행흐름(스택 프레임)을 벗어날 수 있도록 함
    - @autoclosure
        - 자동으로 클로저를 만들어 주는 역할
        - 파라미터가 없는 클로저만 가능함
        - 일반적으로 클로저 형태로 써도 되지만, 번거로울때 사용함
        - 번거로움을 해결하지만 코드가 명확해지지 않아 사용 지양(애플 공식문서)
        - 잘 사용하지 않음 !
        - 기본적으로 non-escaping 특성을 가짐
```swift
// @escaping

// 클로저 단순 실행(non-escaping)
func performEscaping(closure: () -> ()) {
    print("시작")
    closure()
}

performEscaping {
    print("중간")
    print("종료")
}

// 클로저를 외부 변수에 저장
// 대표적으로 사용하는 곳 => 어떤 함수의 내부에 존재하는 클로저를 외부 변수에 저장, GCD(비동기 코드의 사용)
var aSavedFunction: () -> () = { print("프린트") }

func performEscaping2(closure: @escaping () -> ()) {
    aSavedFunction = closure
}

performEscaping2(closure: { print("다른 프린트") })

// GCD 비동기 코드

func performEscaping3(closure: @escaping (String) -> ()) {
    var name = "이름"

    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // 1초 뒤 실행
        closure(name)
    }
}

performEscaping3 { str in
    print("이름 출력: \(name)")
}

// @autoclosure

func someFunction(closure: @autoclosure () -> Bool) {
    if closure() {
        print("TRUE")
    } else {
        print("FALSE")
    }
}

// @autoclosure, @escaping
func someAutoClosure(closure: @autoclosure @escaping () -> String) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        print("3초 뒤 실행되는 프린트문")
    }
}
```
10. 객체 내에서 클로저의 사용
- 클로저 내에서 객체의 속성 및 메서드에 접근하는 경우 self 키워드를 반드시 사용해야 한다.
    - 강한 참조를 하고 있다는 것을 표시하기 위한 목적이고, Dog의 RC를 올리는 역할을 한다.
```swift
class Dog { 
    var name = "초코"

    func doSomething() {
        // 비동기적으로 실행하는 클로저
        // 해당 클로저는 오래 저장할 필요가 있음 => 새로운 스택을 만들어 실행하기 때문
        DispatchQueue.global().async { // 다른 CPU에 작업을 요청
            print("제 이름은 \(self.name) 입니다.")
        }
    }
}

var Choco = Dog()
choco.doSomething()
```
- 클로저는 기본적으로 캡처 현상이 발생한다.
- 클로저와 인스턴스가 강한참조로 서로를 가르키고 있다면, 메모리에서 정상적으로 해제되지 않고 메모리 누수현상이 발생한다.
- 캡처리스트 내에서 약한 참조 또는 비소유 참조를 선언하여 문제를 해결할 수 있다.
```swift
class Person {
    let name = "홍길동"

    func sayMyName() {
        print("나의 이름은 \(name) 입니다.")
    }

    func sayMyName1() {
        DispatchQueue.global().async {
            print("나의 이름은 \(self.name) 입니다.")
        }
    }

    func sayMyName2() {
        DispatchQueue.global().async { [weak self] in
            print("나의 이름은 \(self?.name) 입니다.")
        }
    }

    func sayMyName3() {
        DispatchQueue.global().async { [weak self] in
            guard let weakSelf = self else { return }
            print("나의 이름은 \(weakSelf.name) 입니다.") // Guard 문
        }
    }
}
```