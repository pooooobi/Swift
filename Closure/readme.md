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