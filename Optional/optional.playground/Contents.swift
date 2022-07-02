import UIKit

var number: Int? = 7
var noNumber: Int?
var hello: String? = "안녕하세요"
var name: String? = "홍길동"
var noString: String?
var newNum: Double? = 5.5
var noDoubleNumber: Double?

if let num = number {
    print(num)
}

if let hi = hello {
    print(hi)
}

if let realName = name {
    print(realName)
}

if let num = newNum {
    print(num)
}

func doGuardLetBinding(_ num: Int?) {
    guard let number = num else { return }
    print(number)
}

func doGuardLetBinding(_ str: String?) {
    guard let string = str else { return }
    print(string)
}

func doGuardLetBinding(_ num: Double?) {
    guard let number = num else { return }
    print(number)
}

doGuardLetBinding(number)
doGuardLetBinding(noNumber)
doGuardLetBinding(hello)
doGuardLetBinding(name)
doGuardLetBinding(noString)
doGuardLetBinding(newNum)
doGuardLetBinding(noDoubleNumber)
