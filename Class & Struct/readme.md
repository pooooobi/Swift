# 클래스(Class)와 구조체(Struct)
클래스는 객체지향 프로그래밍과 연관있는데, 클래스(틀)을 통해 객체를 생성하고 그 안에 들어있는 값을 정리한다고 보면 편하다.
```swift
// 클래스의 선언 -> 틀 생성
class Dog {
    var name = "이름"
    var weight = 0.0

    func sit() {
        print("앉았습니다.")
    }
    func layDown() {
        print("누웠습니다.")
    }
}

// 객체의 생성
var bori = Dog()

// 값에 접근하기
bori.name
bori.name = "보리"
bori.name

bori.weight
bori.weight = 3
bori.weight
```

## 클래스의 정의와 객체의 생성
위 코드를 바탕으로 책에 관한 내용으로 클래스를 정의하고 객체를 생성해보자.
```swift
// 클래스의 선언
class Book {
    // 속성(Property)
    var name = ""
    var price = 0
    var pages = 0
    
    // 메서드(Method)
    func showBookDetails() {
        print("책의 이름은 \(name), 가격은 \(price), 페이지는 \(pages) 페이지 입니다.")
    }
}

// 객체의 생성
var swiftBook = Book()

// 객체의 접근
swiftBook.name = "The Swift Programming"
swiftBook.price = 100
swiftBook.pages = 1200

// 객체 내 메서드 사용
swiftBook.showBookDetails()
```

## 구조체의 정의와 인스턴스(instance)의 생성
구조체 또한 클래스와 다르지 않다. 틀을 만드는 작업 또한 같은 일이고, `class`라고 적혀있는걸 `struct`(구조체) 라고 변경해도 된다.
```swift
// 구조체의 선언
struct Book {
    // 속성(Property)
    var name = ""
    var price = 0
    var pages = 0
    
    // 메서드(Method)
    func showBookDetails() {
        print("책의 이름은 \(name), 가격은 \(price), 페이지는 \(pages) 페이지 입니다.")
    }
}

// 인스턴스 생성
var swiftBook = Book()

// 인스턴스의 속성에 접근
swiftBook.name = "The Swift Programming"
swiftBook.price = 100
swiftBook.pages = 1200

// 인스턴스 내 메서드 사용
swiftBook.showBookDetails()
```

## 클래스와 구조체, 뭐가 다른가 ?
클래스와 구조체 둘다 메모리에 찍어낸 것을 인스턴스(instance)라고 한다.<br>
인스턴스는 실제 메모리에 할당되어 구체적 실체를 갖춘 것 이라는 의미이다.<br>
스위프트에서는 클래스의 instance를 `객체(Object)`라고 한다.
```text
클래스의 인스턴스(객체)
구조체의 인스턴스
열거형의 인스턴스
```
가장 큰 차이는 `메모리 저장 방식`의 차이이다.<br>
1. 구조체
    - 값 형식(Value Type)
    - 인스턴스(Instance) 데이터를 모두 스택(Stack) 영역에 저장한다.
    - 값을 전달하거나 복사시 복사본을 생성한다. (메모리 공간 추가 생성)
    - 스택 공간에 저장하며, 스택 프레임(StackFrame) 종료 시 자동 제거된다.

2. 클래스
    - 참조 형식(Reference Type)
    - 인스턴스 데이터는 힙에 저장하고, 해당 힙을 가르키는 변수는 스택에 저장한다.
    - 메모리 주소값이 힙(Heap)을 가르킨다.
    - 복사시 값을 전달하는 것이 아니고 지정 주소를 전달한다.
    - ⭐️ 힙 공간에 저장함에 따라 ARC 시스템을 통해 메모리 관리가 필요하다.

```text
위에서 Book이라는 클래스가 있다.
해당 클래스는 데이터 영역에 틀이 있고, 생성시 힙 영역에 보존된다.
swiftBook의 선언과 동시에 힙 영역에 존재하며, 스택 영역에서는 메모리 주소가 존재한다.

마찬가지로 구조체 또한 데이터 영역에 틀이 존재한다.
하지만 인스턴스를 선언하면 힙에 있지 않고, 스택 영역에 존재한다.
```

## 클래스와 구조체, let & var
```swift
class PersonClass {
    var name = "사람"
}

struct AnimalStruct {
    var name = "동물"
}

let pClass = PersonClass()
let aStruct = AnimalStruct()
```
둘은 무슨 차이가 있을까?<br>
1. `let`을 통한 선언시 클래스에서는 "메모리 주소를 변경할 수 없다"
    - 한가지만 가르키는데, 최초 선언한 pClass에서는 PersonClass의 메모리 주소만 가르킨다. 임의변경 불가
    - aStruct에서는 let으로 선언된 것이 스택 영역에서 보존되어 있다.
2. 따라서, `let`으로 선언 했다 하더라도 pClass는 내부 속성을 변경할 수 있으나 aStruct는 내부 속성을 변경할 수 없다.
```swift
// 가능
pClass.name = "사람1"

// 불가능
// aStruct.name = "동물1"
```

## 점문법 / 명시적 멤버 표현식(Explicit Member Expression)
`.`을 이용하여 내부의 요소(클래스와 구조체의 인스턴스의 속성)에 접근한다.
```swift
var man = PersonClass()
man.name = "테스트"

Int.random(in: 1 ... 10)
```

## 관습적인 선언
1. 속성과 메서드 순서대로 작성한다.
```swift
class Dog {
    var name = ""
    var weight = 0.0

    func sit() {
        print("앉았습니다.")
    }
}
```

## 생성자의 역할, 초기화의 의미
`init`메서드를 사용하여 생성자를 만들어 초기에 값을 넣을 수 있다.
```swift
class Dog {
    var name = "강아지"
    var weight = 0.0

    init(n: String, w: Double) {
        name = n
        weight = w
    }
}
```
만약 init에서 변수 이름이 같으면 어떻게 해야할까 ?
```swift
class Dog {
    var name = "강아지"
    var weight = 0.0

    init(name: String, weight: Double) {
        self.name = name
        self.weight = weight
    }
}
```
1. 모든 저장 속성(변수, property)을 초기화 해야한다. -> 구조체, 클래스 동일함.
2. 생성자 실행 종료시점에는 모든 속성의 초기값이 저장되어 있어야 함(초기화 되지 않는다면? 컴파일 오류 !)
3. 생성자의 목적은 저장 속성 초기화.
4. 클래스, 구조체, 열거형은 모두 설계도일 뿐, 실제 데이터(속성), 동작(메서드)을 사용하기 위해선 초기화 과정이 필요하다.

## 생성자(initializr) 와 self 키워드
인스턴스 내에서 동일한 변수, 상수명을 사용할 때 가르키는 것을 명확하게 하기 위해 `self` 키워드를 사용한다.
```swift
class Dog {
    var name = "강아지"
    var weight = 0.0

    init(name: String, weight: Double) {
        self.name = name
        self.weight = weight
    }
}
```
`self` 키워드는 클래스/구조체 내 해당 인스턴스(자기 자신)를 가르킨다.

## 속성이 옵셔널 타입일 경우
```swift
class Dog {
    var name: String?
    var weight: Int

    init(weight: Int) {
        // self.name = "강아지"
        self.weight = weight
    }

    func sit() {
        print("\(name) 앉았습니다.")
    }
    
    func layDown() {
        print("\(name) 누웠습니다.")
    }
}

var dog1 = Dog(weight: 10)
dog1.name // nil
```
String? 타입에 의해 init에 없어도 nil로 초기화 된다 생각하면 편하다.<br>
옵셔널 타입이기에 배웠던 옵셔널 바인딩으로 벗겨 사용할 수 있다.
```swift
if let name = dog1.name {
    print(name)
}

guard let name = dog1.name else { return }
print(name)
```

## 식별 연산자(Identity Operators)
두개의 참조가 같은 인스턴스를 가르키고 있는지를 비교하는 방법임.<br>
`===`, `!==`를 이용한다.
```swift
var dog1 = Dog(weight: 10)
var dog2 = Dog(weight: 15)

print(dog1 === dog2)
print(dog1 !== dog2)
```