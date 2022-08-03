# 메모리 관리(Automatic Reference Counting)
- 메모리는 코드, 데이터, 힙, 스택 구조로 되어있다.
- 해당 구조에서 힙 영역에 할당되는 데이터를 관리하고 불필요시 해제하는 과정을 거쳐야 한다.
    - 할당이 해제되지 않으면 메모리 누수(Memory Leak) 현상 발생
    - 힙 영역 : 동적 할당(Dynamic Allocation), 크기가 크고 관리가 필요한 데이터가 있는 곳<br><br>
- RC(Reference Counting) => 참조 숫자를 세는 것을 통해 메모리 관리, 컴파일시 메모리 해제시점을 결정함
    - 결론적으로 숫자를 자동으로 세주는 역할을 통해 메모리를 관리한다.
- Swift의 메모리 관리(ARC)는 자동으로 지정되기 때문에, 임의로 개발자가 지정할 수 없다.
- Objective-C의 MRC(Manual Reference Counting)도 존재한다.
```swift
// 개발자 코드
class Point {
    var x, y: Double
    func draw() { ... }
}

let point1 = Point(x: 0, y: 0)
let point2 = point1
point2.x = 5
// use point1
// use point2
```
개발자의 코드는 위와 같을 것이다. 하지만 ARC 모델이 적용된다면?
```swift
// 컴파일된 코드
class Point {
    var refCount: Int
    var x, y: Double
    func draw() { ... }
}

let point1 = Point(x: 0, y: 0) // refCount += 1
let point2 = point1
// retain(point2) => refCount +=1
point2.x = 5
// use point1
// release(point1) => refCount -= 1
// use point2
// release(point2) => refCount -= 1
```
- 예전 언어들은 모든 메모리를 수동으로 관리했다.
    - 따라서 개발자가 모든 메모리 해제 코드까지 삽입해서 실수할 가능성이 매우 높았음
- RC는 다음과 같다.
    - retain() => 할당
        - RC + 1
    - release() => 해제
        - RC - 1
- 메모리 관리도 개발자가 함에 따라 부담감이 높았지만, 다른 언어도 마찬가지로 대부분 자동 메모리 관리 모델을 사용한다.
    - Swift에서 컴파일러가 실제로 retain(), release()를 자동 삽입한다고 보면 된다.
    - 컴파일러가 메모리 관리코드를 자동으로 추가해 줌으로써 프로그램의 메모리 관리에 대한 안전성이 증가했다.
- 따라서 RC가 1 이상이면 메모리에 유지되고, 0이 되면 메모리에서 제거된다고 생각하면 된다.
```swift
class Dog {
    var name: String
    var weight: Double

    init(name: String, weight: Double) {
        self.name = name
        self.weight = weight
    }

    deinit {
        print("\(name) 메모리 해제")
    }
}

var choco: Dog? = Dog(name: "초코", weight: 15.0) // retain(choco), RC = 1
var bori: Dog? = Dog(name: "보리", weight: 10.0) // retain(bori), RC = 1

choco = nil // release(choco), RC = 0 => 초코 메모리 해제
bori = nil // release(bori), RC = 0 => 보리 매모리 해제
```
- 강한 참조 사이클(Strong Reference Cycle & 메모리 누수에 대한 이해)
```swift
class Dog {
    var name: String
    var owner: Person?

    init(name: String) {
        self.name = name
    }

    deinit {
        print("\(name) 메모리 해제")
    }
}

class Person {
    var name: String
    var pet: Dog?

    init(name: String) {
        self.name = name
    }

    deinit {
        print("\(name) 메모리 해제")
    }
}

var bori: Dog? = Dog(name: "보리") // Dog RC = 1
var gildong: Person? = Person(name: "홍길동") // Person RC = 1

bori?.owner = gildong // Person RC = 2
gildong?.pet = bori // Dog RC = 2

bori = nil // Dog RC = 1
gildong = nil // Person RC = 1
```
- 위와 같은 상황에서 메모리 누수가 발생한다. 해결 방안은?
    - bori, gildong에 nil을 부여하기 전에 `bori?.owner = nil`, `gildong?.pet = nil`을 적용해주어야 한다.
- 객체가 서로를 참조하는 `강한 참조 사이클`로 인해 변수의 참조에 nil을 할당해도 메모리가 해제되지 않는 메모리 누수의 상황이 발생하게 되는 것이다.
- 따라서, RC(Reference Counting)를 고려하여 참조 해제 순서를 주의해서 코드를 작성해야 한다. 아래와 같은 방법을 사용하자.
    - Weak Reference(약한 참조)
        - 소유자에 비해 보다 짧은 생명주기를 가진 인스턴스를 참조할때 주로 사용함
        - 참조하고 있던 인스턴스가 사라지면 nil로 초기화 됨
        - 실제 프로젝트에서 주로 사용함
        - let으로 불가, Non-Optional 불가 => 변할 수 있어야하며 nil도 할당할 수 있어야 한다.
    - Unowned Reference(비소유 참조)
        - 소유자 보다 인스턴스의 생명주기가 더 길거나, 같은 경우에 사용함
        - 참조하고 있던 인스턴스가 사라지면 nil로 초기화 되지 않음
        - 따라서, nil처리가 필요하다 !
    - 둘 다 가르키는 인스턴스의 RC의 숫자를 올라가지 않게 한다.
```swift
// 약한 참조(Weak Reference)
class Dog {
    var name: String
    weak var owner: Person?

    init(name: String) {
        self.name = name
    }

    deinit {
        print("\(name) 메모리 해제")
    }
}

class Person {
    var name: String
    weak var pet: Dog?

    init(name: String) {
        self.name = name
    }

    deinit {
        print("\(name) 메모리 해제")
    }
}


var bori: Dog? = Dog(name: "보리") // Dog RC = 1
var gildong: Person? = Person(name: "홍길동") // Person RC = 1

bori?.owner = gildong // RC 변화 없음
gildong?.pet = bori // RC 변화 없음

bori = nil // Dog RC = 0, 메모리 해제
gildong = nil // Person RC = 0, 메모리 해제

// 비소유 참조(Unowned Reference)
class Dog1 {
    var name: String
    unowned var owner: Person1? // Swift 5.3 이전에는 Optional에 unowned에 선언이 안되었음

    init(name: String) {
        self.name = name
    }

    deinit {
        print("\(name) 메모리 해제")
    }
}

class Person1 {
    var name: String
    unowned var pet: Dog1?

    init(name: String) {
        self.name = name
    }

    deinit {
        print("\(name) 메모리 해제")
    }
}

var bori1: Dog1? = Dog1(name: "보리") // Dog RC = 1
var gildong1: Person1? = Person1(name: "홍길동") // Person RC = 1

bori1?.owner = gildong1 // RC 변화 없음
gildong1?.pet = bori1 // RC 변화 없음

bori1 = nil // Dog RC = 0, 메모리 해제
gildong1 = nil // Person RC = 0, 메모리 해제
```
- 클로저에서 강한 참조 사이클을 어떻게 해결할 수 있을까? => 캡처 리스트와 관련
    - 캡처 현상에 관한 내용은 Closure 폴더의 readme.md 파일을 확인하자.
```swift
// value 타입의 캡처
var num = 1
let valueCaptureClosure = {
    print("밸류 출력(캡처) : \(num)")
}

num = 7
valueCaptureClosure() // 7 출력

num = 1
valueCaptureClosure() // 1 출력
```
- 스택 프레임에서 num이 변하고, valueCaptureClosure는 클로저의 주소를 가르킨다.
    - 반대로 클로저는 num을 스택 프레임에 있는 num의 주소를 가르킨다.
- 캡처리스트는 어떻게 사용할까 ?
```swift
let valueCaptureListClosure = { [num] in
    print("밸류 출력(캡처리스트) : \(num)")
}
```
- 클로저(힙에 있는)는 num의 값을 가져와 보관하게 된다.
    - 메모리 주소를 보관하지 않는다. 값을 직접적으로 복사해서 사용한다.
        - 캡처 => 주소를 보관, 캡처리스트 => 값을 복사하여 보관
- 참조(Reference) 타입의 캡쳐와 캡쳐리스트는?
```swift
class SomeClass {
    var num = 0
}

var x = SomeClass()
var y = SomeClass()

print("참조 초기값 : ", x.num, y.num)

let refTypeCapture = { [x] in 
    print("참조 출력값(캡처리스트) : ", x.num, y.num)
}
```
- x => 참조타입 주소값 캡처, x를 직접 참조로 가르킴
- y => 변수를 캡처해서, y 변수를 가르킴
- 해결 방안은?
```swift
// 캡처리스트 안에서 weak/unowned 사용
var s = SomeClass()

let captureCapture1 = { [weak z] in
    print("참조 출력값 : ", z?.num) // Optional => ? 붙여야 함
}

let refTypeCapture2 = { [unowned z] in
    print("참조 출력값 : ", z.num)
}

// 캡처리스트 안에서 바인딩도 가능
```