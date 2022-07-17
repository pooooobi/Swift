# 속성과 메소드(Property & Method)
구조체와 클래스는 근본적으로 차이가 나는 것들이 있다.<br>
하지만 속성과 관련된 것들은 거의 차이가 없다.<br>
하지만 메서드를 살펴보면 근본적인 차이가 있는데 해당 부분을 살펴보자.

## 저장속성(Stored Properties)
값이 저장되는 일반적인 속성(변수)를 저장 속성이라 칭함.
```swift
struct Bear {
    var name: String
    var weight: Double

    init(name: String, weight: Double) {
        self.name = name
        self.weight = weight
    }

    func eat() {
        print("\(name) 이 음식을 먹습니다.")
    }
}

var aBear = Bear(name: "귀여운 곰", weight: 133.5)
aBear.name
aBird.weight
```
1. 저장 속성은 구조체와 클래스가 동일하다.
2. `let` 또는 `var`로 선언할 수 있다.
3. 저장 속성은 각 속성 자체가 고유의 메모리 공간을 가진다 !
4. 초기화 이전에 값을 가지고 있거나, 생성자 메서드를 통해 값을 반드시 초기화 해주어야 한다.

## 지연저장속성(Lazy Stored Properties)
지연 저장속성은 처음부터 메모리를 갖지 않는다. `lazy` 키워드를 통해 사용할 수 있다.
```swift
struct Bear {
    var name: String
    lazy var weight: Double

    init(name: String, weight: Double) {
        self.name = name
        self.weight = weight
    }

    func eat() {
        print("\(name) 이 음식을 먹습니다.")
    }
}
```
1. 지연 저장 속성은 해당 저장 속성의 초기화를 지연하는 것이다.
2. 인스턴스가 초기화되는 시점에 속성이 값을 가지는게 아니라, 해당 속성(변수)에 접근할 때 초기화된다.
3. `var`로만 선언할 수 있다.
4. 선언시점에 기본값(default)을 저장해야한다.
5. 나중에 메모리 공간을 생성하는 아주 게으른 녀석이다.

왜 지연 저장 속성을 사용할 까 ?
```swift
class AView {
    var a: Int

    // 1) 메모리 공간을 많이 차지할 때
    lazy var view = UIImageView()

    // 2) 다른 속성을 이용해야 할 때, 혹은 다른 저장 속성에 의존해야 할 때
    lazy var b: Int = {
        return a * 10
    }()

    init(num: Int) {
        self.a = num
    }
}
```
1. 메모리 공간을 많이 차지하는 이미지 등의 속성에 저장할 때
2. 반드시 메모리 공간을 항상 차지할 필요가 없으므로 지연 저장 속성을 통한 메모리 누수(낭비) 방지
3. 다른 속성들을 이용해야 할 때, 초기화 시점에 모든 속성들이 동시에 메모리 공간에 저장되므로, 어떤 한가지 속성이 다른 속성에 접근할 수가 없다.
4. 지연 저장 속성을 이용하는 경우 지연으로 저장된 속성은 먼저 초기화된 속성에 접근할 수 있게 된다.

## 계산 속성(Computed Properties)
계산 속성은 `get`, `set` 두가지로 나누어진다.<br>
내부에서는 실질적으로 함수처럼 계산하고, 해당 값을 가져와 설정해주는 개념이라 생각하면 된다.<br>
_자바의 Getter, Setter와 헷갈리지 말자..._
```swift
class Person {
    var name: String = "사람"
    var height: Double = 160.0
    var weight: Double = 60.0

    var bmi: Double {
        get {
            let result = weight / (height * height) * 10000
            return result
        }
    }
}
```
```swift
class Person {
    var name: String = "사람"
    var height: Double = 160.0
    var weight: Double = 60.0

    var bmi: Double {
        return weight / (height * height) * 10000
    }
}
```
밖에서 해당 인스턴스에 접근해서 `get` 즉, 값을 얻는다는 의미로 사용된다.<br>
그럼 `set`은 어떻게 사용할까?
```swift
class Person {
    var name: String = "사람"
    var height: Double = 160.0
    var weight: Double = 60.0

    var bmi: Double {
        get {
            let bmi = weight / (weight * weight) * 10000
        }
        set(bmi) {
            weight = bmi * height * height / 10000
        }
    }
}
```
밖에서 해당 인스턴스에 접근해서 `set` 즉, 값을 세팅한다는 의미로 사용된다.<br>
1. 읽기만 가능한 계산속성(read-only)는 `get` 블록을 생략할 수 있다.
```swift
class Person {
    var name: String = "사람"
    var height: Double = 160.0
    var weight: Double = 60.0
    
    var bmi: Double {
        get {
            let bmi = weight / (height * height) * 10000
            return bmi
        }
        set {
            weight = newValue * height * height / 10000
        }
    }
}
``` 
2. set 블록의 파라미터를 생략하고 `newValue`로 대체할 수 있다.
```swift
class Person {
    var name: String = "사람"
    var height: Double = 160.0
    var weight: Double = 60.0
    
    var bmi: Double {
        get {
            let bmi = weight / (height * height) * 10000
            return bmi
        }
        set {
            weight = newValue * height * height / 10000
        }
    }
}
```
메서드가 아닌 속성방식으로 구현하면 무슨 장점이 있을까?
1. 관련있는 두가지 메서드를 한번에 구현할 수 있다.
2. 외부에서 보기에 속성이름으로 설정 가능하기에 보다 명확하다.
3. 메서드를 개발자들이 보다 읽기 쉽고 명확하게 쓸 수 있는 형태인 속성으로 변환해 놓은 것이다.
4. 계산 속성은 '겉모습은 속성(변수)'의 형태를 가진 메서드(함수)임
5. 메모리 공간을 가지지 않고 해당 속성에 접근했을 때, 다른 속성에 접근하여 계산한 후 그 결과를 리턴하거나 세팅하는 메서드다.

아래와 같은 내용은 주의하자.
1. 항상 변하는 값이므로 `var`로만 선언 가능하다.
2. 자료형 선언을 해야한다. 형식 추론 형태 안된다. 정식 선언 해야한다.
3. get은 반드시 선언 해야하나, set은 선택이다.

## 타입 속성(Type Properties)
타입 속성에는 `저장 속성`, `계산 타입 속성` 두가지가 존재한다.
```swift
class Dog {
    
    static var species: String = "Dog"
    
    var name: String
    var weight: Double
    
    init(name: String, weight: Double) {
        self.name = name
        self.weight = weight
    }

}

let dog = Dog(name: "초코", weight: 15.0)
dog.name
dog.weight

// dog.species -> 이거 안됨 !
Dog.species
```
`static` 고정적인, 고정된 이라는 키워드를 추가한 저장속성이다.<br>
접근은 인스턴스에서 점을 찍어도 나타나지 않아, 타입(형식)에 접근연선자로 접근한다.<br>
저장 속성, 계산 속성 두가지 모두 타입 속성이 될 수 있다.
1. 저장 타입(형식) 속성
```swift
class Circle {
    
    // (저장) 타입 속성 (값이 항상 있어야 함)
    static let pi: Double = 3.14
    static var count: Int = 0   // 인스턴스를 (전체적으로)몇개를 찍어내는지 확인
    
    // 저장 속성
    var radius: Double     // 반지름
    
    // 계산 속성
    var diameter: Double {     // 지름
        get {
            return radius * 2
        }
        set {
            radius = newValue / 2
        }
    }
    
    // 생성자
    init(radius: Double) {
        self.radius = radius
        //Circle.count += 1
    }   
}
```
2. 계산 타입(형식) 속성
```swift
class Circle {
    
    // 저장 타입 속성
    static let pi: Double = 3.14
    static var count: Int = 0
    
    
    // (계산) 타입 속성(read-only)
    static var multiPi: Double {
        return pi * 2
    }
    
    // 저장 속성
    var radius: Double     // 반지름
    
    
    // 생성자
    init(radius: Double) {
        self.radius = radius
    }
    
}
```

## 타입 속성에 대한 메모리 구조의 이해
1. 인스턴스를 생성할 때, 생성자에서 모든 속성을 초기화
2. 해당 저장 속성은 각 인스턴스가 가진 고유한 값임
3. 저장 타입 속성은 생성자(init)가 필요없기 때문에 타입 자체에 속한 속성이기에 항상 기본값 필요(생략 불가)
4. 지연 속성(lazy)의 성격을 가짐
5. 저장 타입속성은 기본적으로 지연 속성이지만, lazy라고 선언할 필요가 없음
    - 여러 스레드에서 동시에 엑세스해도 한번만 초기화 됨 -> Thread-Safe

주의할 점은 아래와 같다.
1. 타입 속성은 클래스, 구조체, 열거형에 모두 추가할 수 있다.
2. let 또는 var 둘다 선언 가능
3. 타입 속성은 특정 인스턴스에 속한 속성이 아니기 때문에 인스턴스 이름으로는 접근 불가하다.
    - 타입(형식)에 접근연산자로 접근해야 한다.