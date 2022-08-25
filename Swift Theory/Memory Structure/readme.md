# 메모리 구조(Memory Structure)
프로그래밍에서 가장 처음으로 프로그램이 시작되는 부분은 main(), 메인함수다. <br>
playground에서는 문법을 쉽게 공부하기 위한 목적으로 main()은 보이지 않지만 구현이 되어있다 가정한다.<br>
```text
<기본적인 메모리 구조>
코드, 데이터, 힙, 스택의 4가지 구조로 되어있다.

함수 실행시 함수 실행에 필요한 메모리 공간을 만들고(StackFrame)
함수가 종료되면 해당 스택프레임은 사라진다.
```
## addTwoNumbers 함수의 예제
```swift
func addTwoNumbers(a: Int, b: Int) -> Int {
    var c = a + b
    return c
}

var num1 = 5
var num2 = 3

var num3 = addTwoNumbers(a: num1, b: num2)

print(num3)
```
위 내용은 전역변수가 아닌 메인함수(main())의 영역이라 가정한다.
```text
print:
num3 출력

addTwoNumbers:
임시공간 생성
a라는 상수에 값 저장(Int)
b라는 상수에 값 저장(Int)
c 변수공간 생성
a + b를 더해 임시값 가짐
c에 임시값 저장
c를 반환함

main:
num1 -> 5, num2 -> 3 저장
num3 공간생성
num1, num2를 이용해 addTwoNumbers 함수 실행 // 실행 함수의 스택에 주소를 저장시킴
리턴(반환)값 num3에 저장
num3 프린트함
```
메인함수에서 진행되다 addTwoNumbers -> main -> print -> stackFrame 영역 삭제 까지 진행된다.

## startFunction 함수의 예제
```swift
var total: Int = 0 // 전역변수, 데이터 영역

func square(_ i: Int) -> Int {
    return i * i
}

func squareOfSum(_ x: Int, _ y: Int) -> Int {
    var z = square(x + y)
    return z
}

func startFunction() {
    var a = 4
    var b = 8
    total = squareOfSum(a, b)
}

startFunction()
```
위와 같은 코드가 있고, 메모리 구조는 아래와 같다.
```text
total -> 데이터 영역
main(), startFunction() -> 스택(StackFrame 영역)
a, b의 변수가 StackFrame 내 startFunction 안에 존재

squareOfSum이 스택 영역에 생성
squareOfSum의 z 변수영역 생성 및 square 스택 영역 생성
square 계산 후 스택 영역에서 사라짐
squareOfSum에서 계산 후 startFunction에 리턴 후 사라짐
```

## 메서드는 메모리에서 어떻게 동작할까 ?
```swift
class Dog {
    var name: String
    var weight: Int

    init(name: String, weight: Int) {
        self.name = name
        self.weight = weight
    }

    func sit() {
        print("\(name) 앉았습니다.")
    }

    func layDown() {
        print("\(name) 누웠습니다.")
    }
}
```
위와 같은 코드가 있다. 해당 클래스는 데이터 영역에 선언될 것이고, 내부에 있는 메서드(method)는 데이터 영역 내 클래스에서 메모리 주소로 존재한다.<br>
메모리 주소는 코드로 연결되고 스택 영역에서 메서드가 생성되어 실행되고, 만료시 파기된다.