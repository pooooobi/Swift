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