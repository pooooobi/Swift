# 메서드 디스패치(Method Dispatch)
- 클래스와 프로토콜의 메서드가 실행되는 방식(Method Dispatch)에 대한 이해에 대해 다룬다.
1. 스위프트가 함수를 실행시키는 방법은 3가지가 존재한다.
    - (Compile time) Direct Dispatch => 직접, static
        - 컴파일 시점에 코드 자체에 함수의 메모리 주소 삽입
        - 명령 코드를 해당 위치에 심음(In-line)
    - (Runtime) Table Dispatch => 동적, Dynamic
        - 함수의 포인터를 배열 형태 보관 후 실행
        - 클래스와 프로토콜에서 사용
        - Virtual Table, Witness Table로 나뉨(프로토콜을 실행시켰을 때)
    - (Runtime) Message Dispatch => 메세지
        - 상속구조를 모두 흝은 뒤에 실행할 메서드를 결정함
        - Objective-C 클래스에서 사용하며 Objective-C 런타임에 의존함

구분 | 본체(initial Declaration) | Extension | 비고
:--|:--| :-- | :--
Value Type(Struct) | Direct Dispatch | Direct Dispatch | -
Protocol | Table Dispatch(Witness) | Direct Dispatch(메서드 디폴드 구현 제공) | 본체 요구사항 메서드를 Witness Table로 구현
Class | Table Dispatch(Virtual), final => Direct | Direct Dispatch(상속시 재정의 불가 원칙), @objc dynamic - Message | @objc dynamic 키워드를 통해 Message Dispatch로 바뀌면 extension 내 메서드 재정의 가능
@objc dynamic | Message Dispatch | Message Dispatch | -

## 직접 디스패치(Direct Dispatch, Static)
```swift
struct MyStruct {
    func method1() {
        print("Struct - Direct method 1")
    }

    func method2() {
        print("Struct - Direct method 2")
    }
}
```

## 테이블 디스패치(Table Dispatch, Dynamic)
```swift
class FirstClass {
    func method1() {
        print("Class - Table method 1")
    }
    
    func method2() {
        print("Class - Table method 2")
    }
}

class SecondClass: FirstClass {
    override func method2() { 
        print("Class - Table method 2-2")
    }
    
    func method3() {
        print("Class - Table method 3")
    }
}
```

## 메세지 디스패치(Message Dispatch)
- 이전에 Objective-C의 동작방식이다.
```swift
class ParentClass {
    @objc dynamic func method1() {
        print("Class - Message method 1")
    }
    @objc dynamic func method2() {
        print("Class - Message method 2")
    }
}

class ChildClass: ParentClass {
    @objc dynamic override func method2() {
        print("Class - Message method 2-2")
    }
    @objc dynamic func method3() {
        print("Class - Message method 3")
    }
}
```