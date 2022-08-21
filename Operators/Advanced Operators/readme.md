# 고급 연산자(Advanced Operators)
1. 숫자 리터럴
    - 스위프트의 숫자 리터럴 표기 : 기존에 사용하던 것
        - 2, 8, 16진법으로 사용하려면? `0b`, `0o`, `0x`로 시작하면 된다.
    - 큰 숫자는 _(언더바)를 통해 표기 가능하다.
        - 언더바는 컴파일러가 무시한다.
    - 스위프트의 정수 타입
        - 플랫폼 사양에 따라 Int, UInt 사용
            - 8Bit : Int8, UInt8
            - 16Bit : Int16, UInt16
            - 32Bit : Int32, UInt32
            - 62Bit : Int64, UInt64
        - Int, UInt 사용시 기본적으로 대부분 64비트를 사용함.
            - 32비트를 사용하는 운영체제는 요즘 보기 힘들다.
```swift
// 스위프트의 숫자 리터럴을 표기하는 방법
var num: Int = 25

// 2, 8, 16진법도 가능하다.
num = 0b00011001 // 0b로 시작, 2진법
num = 0o31 // 0o로 시작, 8진법
num = 0x19 // 0x로 시작, 16진법

// 큰 숫자를 읽기 쉽게 하기 위해 _(언더바) 사용 가능
// 언더바는 컴파일러가 무시함
num = 1_000_000
num = 10_000_000

// 메모리 바이트 사용 확인
MemoryLayout<Int8>.size // 1(Byte)
Int8.max // 127 (2^7 - 1)
Int8.min // -128 (-2^7)

MemoryLayout<UInt8>.size // 1(Byte)
UInt8.max // 256 (2^8-1)
UInt8.min // 0, UInt는 양수만 저장한다

MemoryLayout<Int>.size // 8(Byte)
Int.max // ...(2^63 - 1)
Int.min // ...(-2^63)
```

2. 오버플로우(overflow)
    - C나 Objective-C에서는 값이 넘치는 현상(overflow)를 허락했지만, 스위프트는 오버플로우를 기본적으로 허락하지 않음 => 크래시
    - 특정한 경우에, 특정 패턴을 구현하기 위해 오버플로우를 허용할 때가 필요한데, 이런 경우를 위해 오버플로우 연산자를 마련해 놓았음.
    - 오버플로우는 양과 음의 방향을 모두 의미함을 유의하자. (positive/negative)
    - 오버플로우 연산자
        - `&+` : 오버플로우 더하기 연산자
        - `&-` : 오버플로우 빼기 연산자
        - `&*` : 오버플로우 곱하기 연산자
        - `&`가 붙는것이 특징이다.
```swift
// 부호가 없는(Unsigned) 경우
var a = UInt8.max // 256
a = a &+ 1 // a가 0으로 돌아옴

// 부호가 있는(Signed) 경우
var a1 = Int8.max // 127
a1 = a1 &+ 1 // a가 -128로 돌아옴

var b1 = Int8.min // -128
b1 = b1 &- 1 // a가 127로 돌아옴

var c1 = Int8.max
c1 = c1 &* 2 // 비트가 한칸씩 이동함
```

3. 논리 연산자와 단락 평가
    - 논리 연산자(Logical Operators)
        - NOT, AND, OR 같은것을 의미함
    - 단락 평가(Short-circuit Evaluation)
        - &&에서 false가 있으면 항상 false다.
        - ||에서 true가 있으면 항상 true다.
        - 따라서, 논리 평가식에서 결과도출에 필요한 최소한의 논리식만 평가한다.
        - 쉽게 설명하자면 결과도출에 필요한 과정을 최소한으로만 확인한다는 의미다.
        - 우선순위는 && 다음에 || 다.
```swift
// Logical NOT Operator
!true
!false

// Logical AND Operator
true && true
false && false
true && false

// Logical OR Operator
true || true
false || false
true || false

// 단락 평가
var num = 0

func checking() -> Bool {
    print(#function)
    num += 1
    return true
}

if checking() || checking() {
    // &&로도 실행해서 함수를 한번 실행하는지, 두번 실행하는지 확인할 것
}
```