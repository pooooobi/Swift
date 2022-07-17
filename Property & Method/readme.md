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