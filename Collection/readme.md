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

## 딕셔너리(Dictionary)
데이터를 키와 값, `key-value`의 형태로 하나의 쌍으로 관리하는 `순서없는 컬렉션`

## 집합(Set)
_자주 사용하진 않음_<br>
수학에서 집합과 비슷한 연산을 제공하는 `순서없는 컬렉션`