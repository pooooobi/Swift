# 문자열과 문자(String and Characters)
1. 유니코드(Unicode)
    - 스위프트는 유니코드 체계를 사용중이다.
    - 전 세계의 모든 문자를 컴퓨터에서 일관되게 표현하고 다룰 수 있도록 설계된 산업 표준
    - 예를 들어 윈도우에서는 CP949라 하는 EUC-KR의 형식을 사용해서 맥북에서는 이를 변경해서 사용한다.
        - txt 파일이 CP949로 인코딩 되어있다면 맥북에서 열때 다른 형식으로 인코딩 해야 볼 수 있다.
    - UTF-8의 형식도 자주 사용해서 `let data = Data(string.utf8)`과 같은 코드를 자주 볼수도 있다.
    - 따라서, 스위프트는 문자열을 저장할 때 하나의 문자를 유니코드의 스칼라 값(UTF-32)로 저장한다.
        - 상황에 따라 UTF-8, 16의 방식으로도 변환할 수 있는 방법도 제공하고 있다.
```swift
var string1: String = "Some Swift😃"

for code in string1.unicodeScalars {
    print(code.value)
}

// 따라서 위 내용을 통해 16진법으로 변환한 값을 넣어도 동일값이 나온다.
string1 = "\u{53}\u{6F}\u{6D}\u{65}\u{20}\u{53}\u{77}\u{69}\u{66}\u{74}\u{1F603}"
print(string1)
```
- 스위프트는 내부적으로 문자열을 UTF-32 방식으로 저장하지만, 위에서 설명했듯 다른 방식으로 변환도 가능하다.
    - 단, 코드값을 사용하려면 for를 통해 내부에서 요소를 다시 추출해서 사용해야 한다.
```swift
let dogString = "Dog!!🐶"
print(dogString.utf8)

// UTF-8 추출
for codeUnit in dogString.utf8 {
    print("\(codeUnit) ", terminator: "")
}

// UTF-16 추출
for codeUnit in dogString.utf16 {
    print("\(codeUnit)", terminator: "")
}

// UTF-32 추출
for scalar in dogString.unicodeScalars {
    print("\(scalar.value) ", terminator: "")
}
print("")
```
- 따라서, 스위프트는 어떠한 유니코드 인코딩 방식으로도 변환할 수 있다. (쉽다)
- 하지만 유니코드로 인한 스위프트 문자열의 특징도 있고, 주의할 점도 있다.
```swift
var hangul1 = "\u{D55C}" // "한"
print("\"한\"의 글자수 : ", hangul1.count)

var hangul2 = "\u{1112}\u{1161}\u{11AB}"
print("ㅎ + ㅏ + ㄴ 의 글자수 : ", hangul2)

hangul1 == hangul2 // true
```
- 스위프트의 문자열에서는 배열같은 단순 인덱스의 접근이 불가능하다.
    - 문자열을 글자의 의미 단위로 사용하기 때문에 정수 인덱스 사용이 불가하다.
- 스위프트에서 2가지 문자열 자료형을 사용한다.
    - String : Swift String(구조체, 값형식)
    - NSString: Foundation String(클래스, 참조형식)
```swift
var nsString: NSString = "Swift"

// let string: String = nsString => 오류
// String <-> NSString간 자동 형변환이 되지 않아 타입 캐스팅 해야함
let string: String = nsString as String

nsString.length // NSString의 length => UTF-16 기반
string.count // String의 count => 의미 글자수 기반

nsString = string as NSString // 두 형식은 브릿징이 가능(Toll-free Bidged) => 타입 캐스팅으로 호환됨
// 두 자료형은 호환되지만, 유니코드를 처리하는 방식이 매우 다르다.

// word = café 라는 단어가 저장되어 있음

let nsWord = word as NSString

word.count
nsWord.length

// NSString은 Objective-C에서 사용하는 문자열
// NSString에서 더 파생된 개념인 NSAttributedString을 실제 앱을 만들때, 간혹가다 사용하는 경우가 있음
```

2. 문자열의 기본 다루기
    - Multiline String Literals
```swift
// 문자열을 한줄에 입력 -> 명시적인 줄바꿈이 불가능, 원할경우 문자열 내부에 \n 입력
let singleLineString = "These are \nthe same."

/* 
문자열을 여러개 입력하고 싶을 때
1. """ 입력 -> 첫째줄, 마지막줄
2. 해당 줄에는 문자열 입력 불가
3. 문자열 내부에서 쓰여진대로 줄바꿈됨. 줄바끔을 하지 않으려면 \ 입력
4. 특수문자는 문자 그대로 입력됨
5. 마지막 """는 들여쓰기의 기준 역할을 함
*/

let longString = """
    Hello,
    "Stranger"
    """
```
- 문자열 내에서 특수 문자(Escape character sequences)
    - `\0` (null)
    - `\\` (백슬래시)
    - `\t` (탭)
    - `\n` (줄바꿈)
    - `\r` (캐리지 패턴, 앞줄 이동)
    - `\"` (쌍따옴표)
    - `\'` (작은따옴표)
    - `\u` (유니코드 값)
- 로스트링(Raw String) -> 확장 구분자 (Extended String Delimiters) #
    - `#` 기호로 문자열 앞 뒤를 감싸면 내부의 문자열을 글자 그대로 인식한다.
    - Escape sequence: \# (#의 개수는 앞 뒤의 개수에 따라 변경)

3. 문자열 보간법(String Interpolation)
    - 문자열 내에서 `\(표현식)`, 상수, 변수, 리터럴 값, 그리고 표현식의 값을 표현할 수 있다.
    - 문자열 보간법을 사용하면 출력 형태(방법)을 직접 구현할 수도 있다.
```swift
let name = "짱구"
print("나는 누구? \(name)!")

struct Dog {
    var name: String
    var weight: Double
}

let dog = Dog(name: "초코", weight: 15.0)
print("\(dog)")
print(dog)
// 위 프린트는 동일함

dump("\(dog)") // 문자열 자체로 인식함
dump(dog) // 메모리 구조에서 어떻게 되어있는지가 출력됨

protocol CustomStringConvertible {
    var description: String {
        return ""
    }
}

extension Dog: CustomStringConvertible {
    var description: String {
        return "강아지의 이름은 \(name), 몸무게는 \(weight) 입니다."
    }
}

// \( ) => description 변수를 읽음
// 위 내용은 Swift 4.0까지 사용하던 방식임

// Swift 5에서 문자열 보간법의 동작 원리
struct Point {
    let x: Int
    let y: Int
}

let p = Point(x: 5, y: 7)
print("\(p)") // Point(x: 5, y: 7)

extension String.StringInterpolation {
    mutating func appendInterpolation(_ value: Point) {
        appendInterpolation("X 좌표는 \(value.x), Y 좌표는 \(value.y)")
    }
}

print("\(p)") // X 좌표는 5, Y 좌표는 7

extension String.StringInterpolation {
    mutating func appendInterpolation(_ value: Point, style: NumberFormatter.Style) {
        let formatter = NumberFormatter()
        formatter.numberStyle = style

        if let x = formatter.string(for: value.x), let y = formatter.string(for: value.y) {
            appendInterpolation("X 좌표는 \(x), Y 좌표는 \(y)")
        } else {
            appendInterpolation("X 좌표는 \(value.x), Y 좌표는 \(value.y)")
        }
    }
}

print("\(p, style: .spellOut)") // X 좌표는 five, Y 좌표는 seven
print("\(p, style: .percent)") // X 좌표는 500%, Y 좌표는 700%
print("\(p, style: .scientific)") // X 좌표는 5E0, Y 좌표는 7E0

// 자세한건 enum Style: UInt { }를 확인하자.
```

4. 숫자(정수 및 실수) 등을 문자열로 변환하여 출력하려고 할 때
```swift
var pi = 3.1415926
print("pi의 값 : \(pi)")
```
- 만약 위 내용에서 3.14의 값이 필요하다면?
    - 출력 형식 지정자(Format Specifiers)
```swift
var string: String = ""
string = String(3.1415926)
print(string) // 3.1415926

string = "원하는 숫자는 " + String(format: "%.3f", pi) // 반올림
print(string) // 원하는 숫자는 3.142

string = "원하는 숫자는 " + String(format: "%.2f", pi)
print(string) // 원하는 숫자는 3.14

/*
    출력 형식 지정자의 종류
    %d, %D => 정수
    %2d => 두자리 표현
    %02d => 두자리로 표현, 0 포함
    %07.3f => 7자리로 표현하되 0, .(dot) 포함, 소숫점 아래 3자리
    %@ => 문자열
*/

// 활용 예시
struct Point: Codable {
    var x: Double
    var y: Double
}

extension Point: CustomStringconvertible {
    var description: String {
        let formattedValue = String(format: "$1$.2f, %2$.2f", self.x, self.y)
        return "\(formattedValue)"
    }
}
```

5. 서브 스트링(Substring)의 개념
```swift
var greeting = "Hello, world!"

let index: String.index = greeting.firstIndex(of: ",") ?? greeting.endIndex // ,의 인덱스
let beginning: String.SubSequence = greeting[..< index] // 처음부터 인덱스까지
```
- prefix 등의 메서드를 사용할 때
    - Hello란 beginning 문자열은 greeting 문자열의 메모리 공간을 공유함
    - 스위프트 내부적으로 최적화 되어 있음
    - 수정 등이 일어나기 전까지는 메모리를 공유함
    - 오랜기간 저장하기 위해서 새롭게 문자열로 저장할 필요가 있음
```swift
var word: String.SubSequence = greeting.prefix(5)
word // String.SubSequence 타입, "Hello"

greeting = "Happy"

print(beginning) // Hello
print(word) // Hello

word = greeting.suffix(3)
word // String.SubSequence 타입, "ppy"
```

6. 문자열 다루기(문자열 인덱스)
    - 문자열 <-> 배열 (쉽게 변환)
```swift
var someString = "Swift"

// 1) 문자열을 문자열(String) 배열로 변경
var array: [String] = someString.map { String($0) }
print(array)

// 2) 문자열을 문자(Character) 배열로 변경
var array2: [Character] = Array(someString)

// 문자열을 문자열(String) 배열화하는 방법
var array3: [String] = Array(arrayLiteral: someString)

// 3) 문자열 배열[String]을 문자열로 변경
var newString = array.joined()
newString = array3.joined()

// 4) 문자 배열[Character]을 문자열로 변경
var newString2 = String(array2)

// 활용 예시: 문자열을 섞는다면
someString.randomElement()
someString.shuffled()

var newString3 = String(someString.shuffled())

newString3 = someString.map { String($0) }.shuffled().joined()
```

7. 문자열 다루기(문자열, 서브스크립트, 문자열 인덱스)
```swift
// 문자열의 대소문자 변형
var string = "swift"

string.lowercased() // 전체 소문자로 바꾼 문자열 리턴
string.uppercased() // 전체 대문자로 바꾼 문자열 리턴
string.capitalized // 대문자로 시작하는 글자로 리턴(원본 그대로)

// 문자열 다루기의 기본(count, isEmpty)
var emptyString = " "

emptyString.count // 1
emptyString.isEmpty // false

emptyString = ""

emptyString.count // 0
emptyString.isEmpty // true

if emptyString == nil {
    print("nil")
}
// 위 내용에서는 String 타입이지 String? 타입이 아니므로 nil이 절대 될 수 없다.

// String의 인덱스(색인, 순번) 타입
/*
    문자열의 인덱스는 정수가 아니다.
    스위프트는 문자열을 글자의 의미 단위로 사용하기 때문에, 정수 인덱스를 사용할 수 없다.

    *** String.Index 타입 ***
        - 문자열.startIndex
        - 문자열.endIndex
        - 문자열.index(i: String.index, offsetBy: String.IndexDistance)

        - 문자열.index(after: String.Index)
        - 문자열.index(before: String.Index)
           * 인덱스의 크기 비교 가능

        - 문자열.indices => 인덱스의 모음
           * 인덱스를 벗어나는 것에 유의해야 함
        
        - 문자열.firstIndex(of: Character)
        - 문자열.lastIndex(of: Character)

    *** String.Index 범위 ***
        - 문자열.range(of: StringProtocol)
        - 문자열.range(of: StringProtocol, options: String.CompareOptions, range: Range<String.Index>?, locale: Locale?)
           * String.Index를 이용하여 서브스크립트를 활용할 수 있음
    
    *** String.Index의 정수 형태로 거리측정을 할 수 있음 ***
        - 문자열.distance(from: String.Index, to: String.Index)
*/

let greeting = "Guten Tag!"

gretting.startIndex // _rawBits: 1
print(greeting.startIndex) // Index(_rawBits: 1)\n

greeting[greeting.startIndex] // "G"

// 정수형태를 변형해서 사용하는 방식
var someIndex = greeting.index(greeting.startIndex, offsetBy: 2)
greeting[someIndex] // "t"

// 공백 문자열 다음의 글자를 알고 싶을 때
var firstIndex = greeting.firstIndex(of: " ")!
var nextOfEmptyIndex = greeting.index(firstIndex, offsetBy: 1)
greeting[nextOfEmptyIndex] // "T"
```