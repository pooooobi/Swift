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