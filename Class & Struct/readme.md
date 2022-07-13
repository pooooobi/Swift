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