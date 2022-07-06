# 컬렉션(Collection)
Swift에서 데이터를 효율적으로 관리하기 위한(여러개의 데이터를 한꺼번에 다루는 타입) 자료형은 `Array(배열)`, `Dictionary(딕셔너리)`, `Set(세트, 셋트)` 총 세가지가 존재한다.

## 배열(Array)
데이터를 `순서대로 저장`하는 컬렉션<br>
대괄호로 묶어 각각의 데이터를 `요소(element)`라 칭함.<br>
선언 방법
```swift
var numArray1 = [1, 2, 3, 4, 5, 6]
let numArray2 = [3, 4, 20, 5, 6, 7]
var stringArray = ["Text", "Text2", "Text3"]
```
정식 문법
```swift
let stringArray1: Array<String> = []
```
단축 문법
```swift
let stringArray2: [String] = []
```
비어있는 배열의 생성
```swift
let emptyArray1: [Int] = []
let emptyArray2 = Array<Int>()
let emptyArray3 = [Int]()
```
배열의 기본 기능(이것 말고도 많음, 외울 필요 없음)
```swift
numArray1 // 1, 2, 3, 4, 5, 6

numArray1.count // 6(배열의 갯수)

numArray1.isEmpty // false(비어있지 않음)

numArray1.contains(5) // 5를 포함하는지 ? -> true

numArray1.randomElement() // 요소중에서 랜덤으로 추출함.

numArray1.swapAt(0, 1) // 배열의 0번째와 1번째 index에 해당하는 값이 바뀜
```
배열 요소(Array's Element)에 대한 접근
```swift
num1Array // [1, 2, 3, 4, 5, 6]
stringArray // ["text", "text2", "text3"]

stringArray[0] // text
stringArray[1] // text2

stringArray[1] = "text5"
print(stringArray[1]) // text5

stringArray.first // text 반환, 값이 없다면? -> nil 반환 (즉, String? 타입임.)
stringArray.last // text3 반환

stringArray.startIndex // 시작 인덱스를 알려줌 -> 사실 무조건 0 나옴
stringArray.endIndex // endIndex - 1 => 마지막 인덱스

// 활용
stringArray[stringArray.startIndex]
stringArray[stringArray.endIndex - 1]

// ... 이하 생략
```
배열의 삽입(Insert)
```swift
var alphabet = ["A", "B", "C"]

alphabet.insert("D", alphabet.endIndex)
alphabet.insert("a", 0)
alphabet.insert(contentsOf: ["D", "E"], at: alphabet.endIndex)
// insert(newElement: String, at: Int) 혹은 newElement -> contentsOf
```
배열의 교체(Replace)
```swift
alphabet = ["A", "B", "C", "D"]

// 0번째 교체
alphabet[0] = "a"

// 0에서 2까지 교체
alphabet[0...2] = ["x", "y", "z"]

// 0에서 1까지 배열 비우기
alphabet[0...1] = []

// 혹은 교체하는 함수의 문법, 위 0에서 2까지 교체라는 내용과 똑같음. 내부에 들어가는 값만 다름.
alphabet.replaceSubrange(0...2, with: ["a", "b", "c"])
```
배열의 추가(Append)
```swift
alphabet += ["H"]

// 마지막에 추가하는 문법
alphabet.append("H")
alphabet.append(contentsOf: ["H", "I"])
```
배열의 삭제(Remove)
```swift
// sub-script 문법
alphabet[0...2] = []

// 요소 한개를 삭제
alphabet.remove(at: 2)

// 요소 범위 삭제
alphabet.removeSubrange(0...2)

// 처음 혹은 마지막 요소를 삭제
alphabet.removeFirst() // 내부에 값이 없을 경우 defalut: 1이고 String 리턴
alphabet.removeLast()

// 배열의 모든 요소 삭제
alphabet.removeAll() // 모두 삭제
alphabet.removeAll(keepingCapacity: true) // 저장공간을 확보해 둔 채로 내부 데이터만 삭제
```
배열의 기타 기능
```swift
var nums = [1, 2, 3, 6, 3, 1, 2, 5, 9, 8]
// -ed가 붙는 함수는 실제 배열이 정렬되지 않고 결과값만 리턴시킴.

// 배열을 직접정렬, sort
nums.sort() // 배열 자체를 정렬시킴
nums.sorted() // 배열을 정렬시켜 보여주나, 실제 정렬되지는 않음.

// 배열 역순정렬, reverse
nums.reverse()
nums.reversed()

// 새로운 배열을 생성하지 않고, 배열의 메모리를 공유하며 역순으로 열거할 수 있는 형식을 리턴시킴
nums.sorted().reserved()

// 배열을 랜덤으로 섞음
nums.shuffle()
nums.shuffled()
```
배열의 비교 및 활용
```swift
let a = ["A", "B", "C"]
let b = ["a", "b", "c"]

a == b // false
a != b // true

for i in a {
    print(i) // A, B, C
}

// enumerate : 열거하다.
// enumerated -> Named Tuple의 형태로 전달

for tuple in nums.enumerated() {
    print(tuple)
    print("\(tuple.0) - \(tuple.1)")
}

for (index, word) in nums.enumerated() { // 바로 뽑아내기
    print("\(index) - \(word)")
}

for (index, value) in nums.enumerated().reversed() { // 역순으로 뽑아내기
    print("\(index) - \(value)")
}
```

## 딕셔너리(Dictionary)
데이터를 키와 값, `key-value`의 형태로 하나의 쌍으로 관리하는 `순서없는 컬렉션`<br>
배열과 마찬가지로 각 요소(element)는 key-value의 형태로 키와 값의 쌍을 `:(콜론)` 처리 한다.<br>
예시) let dic: Dictionary<String, String> = ["A" : "Apple", "B" : "Banana"]<br>
예시2) let dic: [String: String]<br>
딕셔너리의 키값은 Hashable 해야 검색 속도가 빠르다.
```text
문법적인 약속
1. [] 대괄호로 묶는다.
2. 키값은 유일해야 한다. 중복할 수 없다. 하지만 밸류값은 중복 가능하다.
3. 1개의 딕셔너리에는 동일한 자료형 쌍의 데이터만 담을 수 있다.
4. 키값은 Hashable 해야 한다.
```
딕셔너리 타입 표기(정식 문법)
```swift
let words: Dictionary<Int, String>
```
딕셔너리 타입 표기(단축 문법)
```swift
var words: [String: String] = [:]
```
빈 딕셔너리의 생성
```swift
let emptyDic1: Dictionary<Int, String> = [:]
let emptyDic2 = Dictionary<Int, String>()
let emptyDic3 = [Int: String]()

// 선언 후 비우는 법
var dictionaryEmpty = ["1" : 1, "2" : 2]
dictionaryEmpty = [:]
```
딕셔너리의 기본 기능
```swift
dic = ["A" : "Apple", "B" : "Banana"]

dic.count
dic.isEmpty

dic.randomElement() // return => Named Tuple(Optional)
```
딕셔너리의 각 요소에 대한 접근(키를 통해)
```swift
// 딕셔너리는 주로 서브스크립트를 이용한 문법을 주로 사용한다.
dic = ["A" : "Apple", "B" : "Banana"]

dic["A"] // Apple
print(dic["A"]) // Optional("Apple"), 값이 없을 경우가 있어, 즉 nil의 가능성이 있어 옵셔널 처리됨

// if let 바인딩
if let a = dic["A"] {
    print(a)
} else {
    print("Not found")
}

// 잘 사용하지 않음, default 설정
dic["S", default: "Empty"]

// key, value의 값을 확인, 정렬도 가능함.
dic.keys
dic.values

dic.keys.sorted()
dic.values.sorted()

for key in dic.keys.sorted() {
    print(key)
}
```
1. 딕셔너리는 값만 따로 검색하는 방법을 제공하지 않는다.
2. 서브 스크립트 문법으로 "키"를 전달해야 한다.

딕셔너리의 업데이트 : 삽입, 교체, 추가
```swift
words = [:]

// 삽입하기
words["A"] = "Apple"
words["B"] = "Banana"

// 교체하기
words["B"] = "Bob"

// 정식 함수 문법 (update + insert)
words.updateValue("Blue", forKey: "B")
words.updateValue("Cocoa", forKey: "C") // 새로운 요소가 추가? -> nil 반환

// 전체 교체
words = ["A" : "A"]

// 전체 초기화(빈 딕셔너리로 만들기)
words = [:]
```

## 해쉬(Hash) 함수
`Hash`, `HashValue`, `Hashable`, 어떤 타입이 Hashable 한가?<br>
고정된 길이의 숫자 혹은 글자이면서 유일한 값(특정 입력값에 대해 항상 동일 결과가 나올 때, `hash value`라 함)
```text
Hash Table
12300 : "steve"
12398 : "cook"
... etc

배열(Array)
0 : "steve"
1 : "cook"
... etc
```
실제 저장되는건 해쉬 테이블의 형태다.<br>
이와 마찬가지로, 딕셔너리(Dictionary) 또한 해쉬 테이블의 형태로 저장된다.

## 집합(Set)
_자주 사용하진 않음_<br>
수학에서 집합과 비슷한 연산을 제공하는 `순서없는 컬렉션`