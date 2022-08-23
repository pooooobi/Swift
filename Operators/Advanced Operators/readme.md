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

3. 비트 연산자(Bitwise Operators)
    - 비트 연산이란?
        - 메모리 비트 단위로 직접적인 논리연산을 하거나, 비트 단위 이동시에 사용하는 연산
        - 주로 하드웨어적인 처리에서 사용한다.
        - 연산 속도가 매우 빠르고 짧은 코드로 복잡한 로직을 구현하게 할 수 있다.
    - 비트 연산자의 종류
        - `~` : Bitwise NOT Operator
        - `&` : Bitwise AND Operator
        - `|` : Bitwise OR Operator
        - `^` : Bitwise XOR Operator
        - `<<` : Bitwise Left Shift Operator
        - `>>` : Bitwise Right Shift Operator
```swift
// Bitwise NOT Opeator
// 비트 논리 부정 연산자라고도 하며, 기존 메모리의 비트를 반전시킨다.
let a1: UInt8 = 0b0000_1111 // 15
let b1 = ~a1 // 0b1111_0000 => 240

// Bitwise AND Operator
// 비트 논리 곱 연산자라고도 하며, 두개의 비트가 true(1) 이여야 1이 반환된다.
let a2: UInt8 = 0b1111_1100 // 252
let b2: UInt8 = 0b0011_1111 // 63
let c2 = a2 & b2 // 0b0011_1100 => 60

// Bitwise OR Operator
// 비트 논리 합 연산자라고도 하며, 두개의 비트중 하나만 true(1) 여도 true(1)가 반환된다.
let a3: UInt8 = 0b1011_0010 // 178
let b3: UInt8 = 0b0101_1110 // 94
let c3 = a3 | b3 // 0b1111_1110 // 254

// Bitwise XOR Operator
// 비트 논리 베타 연산자라고도 하며, 두개의 비트를 비교하여 서로 다르면 true(1)가 반환된다.
let a4: UInt8 = 0b0001_0100 // 20
let b4: UInt8 = 0b0000_0101 // 5
let c4 = a4 ^ b4 // 0b0001_0001 // 17

// Unsigned(부호가 없는) 비트 이동 연산자
/* 
    - 기존 비트를 요청된 값만큼 왼쪽 혹은 오른쪽으로 이동
    - 정수(Integer)의 수용 범위를 넘어서는 비트는 어떤 것이든 버림
    - 비트를 왼쪽이나 오른쪽으로 이동하면서 남는 공간에는 0을 삽입
*/

// Bitwise Left Shift Operator
let leftShiftBits: UInt8 = 4 // 0b0000_0100 => 4
leftShiftBits << 1 // 0b0000_1000 => 8, 곱하기 2가 됨
leftShiftBits << 2 // 0b0001_0000 => 16, 2^2 => 곱하기 4가 됨

// Bitwise Right Shift Operator
let rightShiftBits: UInt8 = 32 // 0b0010_0000 => 32
rightShiftBits >> 1 // 0b0001_0000 => 16, 나누기 2가 됨
rightShiftBits >> 2 // 0b0000_1000 => 8, 나누기 4가 됨(2^2)

// Signed(부호가 있는) 비트 이동 연산자
/* 
    - 기존 비트를 요청된 값만큼 왼쪽 혹은 오른쪽으로 이동
    - 정수(Integer)의 수용 범위를 넘어서는 비트는 어떤 것이든 버림
    - 비트를 왼쪽으로 이동하면서 남는 공간에는 0을 삽입
    - 비트를 오른쪽으로 이동하면서 남는 공간에는 부호가 없을 때 0, 부호가 있을 때 1을 삽입함(오른쪽 이동시 주의할 것)
*/

// Bitwise Left Shift Operator
let shiftBits: Int8 = 4 // 0b0000_0100 => 4
shiftBits << 1 // 0b0000_1000 => 8, 곱하기 2가 됨
shiftBits << 2 // 0b0001_0000 => 16, 곱하기 4가 됨(2^2)
shiftBits << 5 // 0b1000_0000 => -128, 2^5승이고, 범위초과로 인해 오버플로우

// Bitwise Right Shift Operator
let shiftSignedBits: Int8 = -2 // 0b1111_1110 => -2
shiftSignedBits >> 1 // 0b1111_1111 => -1, 나누기 2의 몫 및 부호비트 유지
shiftSignedBits >> 2 // 0b1111_1111 => -1, 나누기 4의 몫 및 부호비트 유지
```

 4. 연산자 메서드
 ```swift
"Hello" + ", Swift" // Hello, Swift!

/* 
    위 문자열 더하기는 String 구조체 내부에 타입 메서드로 정의되어 있다.
    
    [문자열 더하기]
    static func + (lhs: String, rhs: String) -> String

    [문자열 복합할당 연산자]
    static func +=(lhs: inout String, rhs: String)
*/

// 1) 연산자 메서드의 구현

// 스위프트 공식문서 예제
struct Vector2D {
    var x = 0.0
    var y = 0.0
}
// 1-1) 산술 더하기 연산자의 구현(infix 연산자)
// infix Operator + : AdditionPrecedence
extension Vector2D {
    static func + (lhs: Vector2D, rhs: Vector2D) -> Vector2D { // static infix func => infix 생략 가능
        return Vector2D(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}

let vector = Vector2D(x: 3.0, y: 1.0)
let anotherVector = Vector2D(x: 2.0, y: 4.0)
let combinedVector = vector + anotherVector

// 1-2) 단항 prefix 연산자의 구현
extension Vector2D {
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
}

let positive = Vector2D(x: 3.0, y: 4.0)
let negative = -positive

// 1-3) 복합할당 연산자의 구현
extension Vector2D {
    static func += (left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
}

// 2) 비교 연산자(==, !=)의 직접적인 구현
/*
    - String 구조체 내부에 타입 메서드로 정의되어 있음

    [Equatable 동일성 비교에 관한 프로토콜]
    static func == (lhs: String, rhs: String) -> Bool
    static func != (lhs: String, rhs: String) -> Bool

    [Comparable 크기, 순서비교에 관한 프로토콜]
    static func < (lhs: String, rhs: String) -> Bool
    static func > (lhs: String, rhs: String) -> Bool
    static func <= (lhs: String, rhs: String) -> Bool
    static func >= (lhs: String, rhs: String) -> Bool

    Comparable 프로토콜을 채택한 타입에서는 모두 위와 같은 메서드가 구현되어 있음
    Comparable 프로토콜은 Equatable 프로토콜을 상속, 동일성 비교가 가능해야 크기 비교도 가능하다.

    Equatable 프로토콜을 채택하기만 하면 컴파일러가 연산자 메서드 구현 내용을 자동으로 추가해준다.
*/

extension Vector2D: Equatable {
    // 내부 자동구현 되어있음.
    // 직접 구현해도 됨.
    static func == (lhs: Vector2D, rhs: Vector2D) {
        return (lhs.x == rhs.x) && (lhs.y == rhs.y)
    }
}

// 연관값이 전혀 없는 열거형의 경우 굳이 Equatable 프로토콜을 채택하지 않아도 연산자 메서드 자동 채택 및 구현됨
 ```

 5. 사용자 정의 연산자
    - `infix` 즉, 중위 연산자의 경우 연산자의 우선 순위 그룹을 지정해야 한다.
        - 중위 연산자가 아닌 경우에는 지정할 필요 없음
```swift
// 중위 연산자
// 1) 우선순위 그룹의 선언
precedencegroup MyPrecedence {
    // HigherThan 또는 lowerThan 둘중에 하나는 반드시 지정해야 한다
    higherThan: AdditionPrecedence // 지정하려는 그룹보다 순위가 낮은 그룹
    lowerThan: MultiplicationPrecedence // 지정하려는 그룹보다 순위가 높은 그룹
    associativity: left // 결합성(left, right, none)
}

// 2) 전역의 범위에서 정의하려는 연산자를 선언하고 우선순위 그룹을 지정한다.
// 단항 => 전치(prefix), 후치(postfix) / 이항 => infix 키워드를 앞에 붙여야 한다.
infix operator += : MyPrecedence

// 3) 연산자의 실제 정의
extension Vector2D {
    static func +- (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y - right.y)
    }
}

let firstVector = Vector2D(x: 1.0, y: 2.0)
let secondVector = Vector2D(x: 3.0, y: 4.0)
let plusMinusVector = firstVector +- secondVector

print(plusMinusVector) // Vector2D(x: 4.0, y: -2.0)

// 중위 연산자가 아닌 경우
// 1) 연산자의 선언
prefix operator +++

// 2) 연산자의 실제 정의
extension Vector2D {
    static prefix func +++ (vector: inout Vector2D) -> Vector2D {
        vector += vector
        return vector
    }
}

var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
let afterDoubling = +++toBeDoubled
// 두 변수 모두 Vector(x: 2.0, y: 8.0)

// 쉬운 예시
prefix operator ++

extension Int {
    static prefix func ++(number: inout Int) {
        number += 1
    }
}

var a = 0
++a // +1
 ```