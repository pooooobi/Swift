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