# 에러처리(Error Handling)
- 에러는 두가지로 나뉜다.
    - 컴파일 타임 에러 => 스위프트 문법과 관련된 에러
    - 런타임 에러 => 프로그램이 실행되는 동안 발생하는 에러
        - 앱이 강제로 종료됨(크래시 발생)
- 에러 처리가 왜 필요할까?
    - 앱이 실행하는 중간에 꺼지는것을 방지
    - 어떤 상황이 발생할지 모르기에(네트워크 통신 중 데이터를 못받거나..) 처리해야 함
    - 예외적인 상황이 발생할 수 있는 가능성을 미리 처리하면 앱이 꺼지는 것을 방지할 수 있음
    - 에러는 일반적으로 함수의 처리과정에서 일어난다.
```swift
// 오류 정의
enum HeightError: Error {
    case maxHeight
    case minHeight
}

// 오류 발생할 수 있는 함수 정의
func checkHeight(height: Int) throws -> Bool {
    if height > 190 {
        throw HeightError.maxHeight
    } else if height < 130 {
        throw HeightError.minHeight
    } else {
        if height >= 160 {
            return true
        } else {
            return false
        }
    }
}

// 오류 처리 + 함수 실행
do {
    let isChecked = try checkHeight(height: 200)
    print("놀이기구를 탑승할 수 있는 키임 : \(isChecked)")
} catch {
    print("놀이기구를 탑승할 수 없음")
}
```
- do => 함수를 통한 정상 처리의 경우 실행하는 블럭
- catch => 함수에서 오류가 발생할 경우 처리하는 블럭
- 위 내용은 에러 정식 처리 방법에 대해 서술하였고, 아래에서는 `try?`, `try!`를 다룬다.
    - try? : 옵셔널 트라이
        - 성공시 리턴 : 정상 리턴타입(옵셔널)
        - 실패시 리턴 : nil
    - try! : Forced 트라이
        - 성공시 리턴 : 정상 리턴타입
        - 실패시 리턴 : 런타임 오류
```swift
/// try? => 옵셔널 트라이
let isChecked = try? checkHeight(height: 200) // Bool?, 당연히 옵셔널 타입을 벗겨서 사용해야 한다.

// try! => Forced 트라이
let isChecked2 = try! checkHeight(height: 150) // Bool, 에러 발생 가능성이 없을 때 사용한다. 런타임 오류 발생의 이유
```
- Catch 블럭의 처리 방법은 아래와 같다.
    - catch 블럭은 do 블럭에서 발생한 에러만 처리하는 블럭이다.
    - 모든 에러를 처리해야만 한다.
```swift
// 패턴이 있는 경우 모든 에러처리를 해야함
do {
    let isChecked = try checkHeight(height: 100)
    print("놀이기구 탑승 가능 여부 : \(isChecked)")
} catch HeightError.maxHeight {
    print("키가 커서 놀이기구 탑승 불가")
} catch HeightError.minHeight {
    print("키가 작아서 놀이기구 탑승 불가")
}

// catch 패턴 없이 처리할 수 있음
do {
    let isChecked = try checkHeight(height: 100)
    print("놀이기구 탑승 가능 여부 : \(isChecked)")
} catch {
    print(error.localizedDescription)

    if let error = error as? HeightError {
        switch error {
        case .maxHeight:
            print("키가 커서 놀이기구 탑승 불가")
        case .minHeight:
            print("키가 작아서 놀이기구 탑승 불가")
        }
    }
}

// Swift 5.3 이후 케이스 나열이 가능해짐
do {
    let isChecked = try checkHeight(height: 100)
    print("놀이기구 탑승 가능 여부 : \(isChecked)")
} catch HeightError.maxHeight, HeightError.minHeight {
    print("놀이기구 탑승 불가")
}
```
- 에러를 던지는 함수를 처리하는 함수
```swift
// 에러 정의
enum SomeError: Error {
    case aError
}

// 무조건 에러를 던지는 함수 정의
func throwingFunc() throws {
    throw SomeError.aError
}

// 에러 처리
do {
    try throwingFunc()
} catch {
    print(error)
}

// 일반적인 함수로 처리 가능
func handleError() {
    do {
        try throwingFunc()
    } catch {
        print(error)
    }
}
```
- throwing 함수로 에러를 다시 던질 수 있다.
    - 함수 내에서 에러를 직접 처리하지 못하는 경우에 사용한다.
```swift
func handleError1() throws { // throws 키워드 필수 !
    try throwingFunc() // catch 없이 밖으로 에러를 던짐
}

// 에러를 받아 처리
do {
    try handleError1()
} catch {
    print(error)
}
```
- rethrowing 함수로 에러를 다시 던질수도 있다. => rethrows 키워드 사용
```swift
// 에러를 던지는 throwing 함수를 파라미터로 받는 경우, 내부에서 다시 에러를 던질 수 있다.

// 다시 에러를 던짐
func someFunction1(callback: () throws -> Void) rethrows {
    try callback()
}

// 다시 에러를 던짐) 에러 변환
func someFunction2(callback: () throws -> Void) rethrows {
    enum ChangedError: Error {
        case cError
    }

    do {
        try callback()
    } catch {
        throw Changed.cError
    }
}

// 처리 방법
do {
    try someFunction1(callback: throwingFunc)
} catch {
    print(error) // aError
}

do {
    try someFunction2(callback: throwingFunc)
} catch {
    print(error) // cError  
}
```
- 메서드와 생성자에서도 throw 키워드를 적용할 수 있다.
    - Throwing 함수 뿐 아니라 메서드와 생성자에도 적용 가능
    - 에러를 던질 수 있는 메서드는 Throwing 메서드, 에러를 던질 수 있는 생성자는 Throwing 생성자를 사용한다.
```swift
enum NameError: Error {
    case noName
}

class Course {
    var name: String

    init(name: String) throws {
        if name == "" {
            throw NameError.noName
        } else {
            self.name = name
        }
    }
}

// 에러 처리
do {
    let _ = try Cousre(name: "Swift")
} catch NameError.noName {
    print("이름이 없어 수업생성에 실패했습니다.")
}

// 재정의
class NewCourse: Course {
    override init(name: String) throws {
        try super.init(name: name)
    }
}
```
- Throwing 메서드, 생성자는 재정의할 때 반드시 Throwing 메서드, 생성자로 재정의 해야한다.
- 일반 메서드, 생성자를 Throwing 메서드, 생성자로 재정의 하는 것은 가능하다.
    - 일반 메서드, 생성자의 범위가 더 크기 때문

- 상속에서의 오류 재정의

상위 | 하위 | 가능/불가능 여부
:--|:--| :-- 
throws | throws 재정의 | 가능
일반 | throws 재정의 | 가능
throws | 일반 재정의 | 불가능
throws | rethrows | 가능
rethrows | throws | 불가능