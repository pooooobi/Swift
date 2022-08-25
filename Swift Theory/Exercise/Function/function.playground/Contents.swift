import UIKit

// 랜덤 문자열 문제
func randomString(_ characters: String) -> String {
    return String(characters.randomElement()!)
}

randomString("랜덤문자열")

// 소수 판별 문제
func primeNumber(_ number: Int) {
    for i in 2 ..< number {
        if number % i == 0 {
            print("소수가 아님")
            return
        }
    }
    print("소수임")
}

primeNumber(97)
primeNumber(98)

// 팩토리얼 문제
func factorial(_ number: Int) -> Int {
    var sum = 1
    for i in 1...number {
        sum *= i
    }
    return sum
}

factorial(5)
factorial(4)
