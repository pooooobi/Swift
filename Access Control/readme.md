# 접근제어(Access Control)
1. 접근제어에 대하여
    - 접근제어는 `private` 처럼 은닉된 키워드를 사용하여 해당 변수를 외부에서 사용할 수 없어, (주로) 내부 함수를 통해 접근하는 것을 의미한다.
        - 다를 수는 있으나, 크게는 클래스의 내부 변수를 통해 바꾼다.
```swift
class SomeClass {
    private var name = "이름"

    func nameChange(name: String) {
        if name == "길동" {
            return
        }
        self.name = name
    }
}

// 해당 클래스에서 이름을 바꾸려면?
let object1 = SomeClass()

object1.nameChange(name: "인영")
```

2. 스위프트의 5가지 접근 수준(Access Levels)

키워드 | 접근 수준 | 비고
:--|:--| :-- 
open | 다른 모듈에서도 접근 가능 | 상속, 재정의 가능(제한낮음), 클래스의 가장 낮은 수준
public | 다른 모듈에서도 접근 가능 | 상속, 재정의가 불가, 구조체 및 열거형의 가장 낮은 수준
internal | 같은 모듈 내에서만 접근 가능 | default
fileprivate | 같은 파일 내에서만 접근 가능 | -
private | 같은 스코프에서만 접근 가능 | 제한 높음

- 이외에도 모듈은 프레임워크, 라이브러리, 앱 등에서 import 해서 사용할 수 있는 외부 코드를 의미한다.
- 접근제어를 가질 수 있는 요소는 다음과 같다.
    - 참고 : Swift Documents -> Entity
    - 타입 : 클래스, 구조체, 열거형, 스위프트의 기본 타입 등
    - 변수, 속성
    - 함수, 메서드(생성자 init, 서브스크립트 subscripts 포함)
    - 프로토콜도 특정영역으로 제한될 수 있다.
- 클래스의 접근 수준을 가장 넓히려면 `open` / 구조체는 `public`
    - 클래스: open, 상속 및 재정의와 관계되어 있음
    - 구조체: public, 구조체에서는 상속이 없음
- 변수
    - public variable에 속한 타입은 더 낮은 접근수준을 가질 수 없다.
    - public <-> internal <-> fileprivate <-> private
- 함수
    - 파라미터, 리턴 타입이 더 낮은 접근수준을 가질 수 없다.
    - internal <-> fileprivate <-> private
```swift
var some: String = "접근 가능"

internal func someFunction(a: Int) -> Bool {
    print(a) // Int
    print("Hello") // String
    return true // Bool
}

// 자신보다 내부에서 더 낮은 타입을 사용하면 접근할 수 없어 사용하지 못할 수 있음 !

// 기본 문법
// 타입
public class SomePublicClass { }
internal class SomeInternalClass { }
fileprivate class SomeFilePrivateClass { }
private class SomePrivateClass { }

// 변수 및 함수
public var somePublicVariable = 0
internal let someInternalConstant = 0
fileprivate func someFilePrivateFunction() { }
private func somePrivateFunction() { }

// 아무 키워드도 붙히지 않으면?
class SomeInternalClass { }
let someInternalConstant1 = 0
```

3. 접근제어가 필요한 이유가 뭘까?
    - 애플이 자신들이 원하는 코드를 감출 수 있다.
    - 코드의 영역을 분리시켜 효율적으로 관리할 수 있다.
    - 컴파일 시간이 줄어든다.
        - 컴파일러가 해당 변수는 어느 범위에서만 쓰이는지 인지할 수 있기 때문에

4. 실무에서 사용하는 관습적인 패턴 종류
```swift
// 속성(변수) 선언시 private으로 외부에 감추려는 속성은 _(언더바)를 사용하여 이름을 짓는다
class SomeOtherClass {
    private var _name = "이름"
    
    var name: String {
        return _name
    }
}

// 저장속성의 (외부에서) 쓰기 제한
class SomeAnotherClass {
    private(set) var name = "이름"
}
```