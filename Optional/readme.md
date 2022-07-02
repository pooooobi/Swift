# 옵셔널(Optional)
모든 프로그래밍 언어에서 선언 후 초기화를 하지 않거나, 값이 없는 경우 오류가 발생한다.
```swift
// 예시
var name: String // 선언
print(name) // 오류 발생
```
왜 오류가 발생할까? 해당 변수가 선언된 후 초기화되지 않아 메모리 주소로 찾아가면 비어있기 때문이다.

## 옵셔널의 선언 및 이해
1. 선언할 때 `?` 키워드만 붙이면 된다. `Int?`, `String?` 처럼 선언하며, 임시값으로 nil을 넣어둔다.
    - 정식 문법 표기는 `Optional<형태>`다.
    - ex) `Optional<Int>`, `Optional<String>`
2. nil은 값이 없음을 표현한다.
    - 다른 언어에서는 null로 표현하지만, 다른 이유는 실제 값이 비어있는 것 'null' 과 현재 없는 것 'nil' 의 차이다.)
3. Optional 타입과 Non-Optional 타입은 서로 다른 것이다.
4. 옵셔널로 변수 선언 후 사용하지 않는다면 자동적으로 nil로 초기화된다.
    - 역으로 nil로 초기화 할 수 있다. (대입할 수 있다.)
5. 옵셔널은 값이 없을 수도 있는 `임시적인 타입`이다.
6. Int를 Int? 타입에 담을 수는 없으나, Int?로 자동 변환되어 담긴다.
7. 옵셔널 타입끼리 연산할 수 없다.
    - 당연히 계산도 불가능하다.

## 옵셔널의 사용
```swift
var num: Int?
var str: String? = "테스트"

print(num) // nil\n
print(str) // Optional("테스트")
```
값이 없을수도 있는 경우를 포함하는 타입 -> Optional

## 옵셔널의 추출
1. 강제로 값을 추출하는 방법 : 값이 안에 확실하게 들어있을 경우 (Forced Unwrapping)
    - 강제 추출연산자 `!`를 옵셔널 표현식 뒤에 붙이면 된다.
    - 일반적으로는 사용하지 않는다.
```swift
// 옵셔널의 사용 코드에 이어서...

// print(num!) -> 값이 들어있지 않으므로 오류 발생
print(str!) // 테스트
```
2. if문으로 nil이 아닌것을 확인한 후 강제로 벗기기
```swift
if str != nil {
    print(str!)
}
```
3. 옵셔널 바인딩 : 바인딩될 경우 특정 작업을 실행하겠다는 뜻 (if let 바인딩)
```swift
if let s = str { // s 변수에 str이 담긴다면
    print(s)
}

var optionalTest: String? = "테스트"

if let testToOptional = optionalTest {
    print(testToOptional)
}

// guard let 바인딩을 많이 사용한다.
func doOptionalBinding(str: String?) {
    guard let n = str else { return }
    print(n)
}
```
4. 닐 코얼레싱(Nil-Coalescing) 연산자를 사용하는 방법
    - coalesce : 영어로(더 큰 덩어리로) 합치다.
```swift
var usernameInfo: String? = "가나다"

var username = usernameInfo ?? "인가되지 않은 사용자" // usernameInfo에 값이 있다면 "가나다"가, 없다면 "인가되지 않은 사용자"가 들어온다.
```
위 코드를 살펴보면 직접 값을 벗겨 사용하진 않고, default value를 제시하여 nil일 때 들어갈 값을 제시함으로써 옵셔널을 제거하는 것이다.<br>
위 코드에서 usernameInfo가 nil이면 값을 벗길 수 없으나 username에 `usernameInfo ?? "인가되지 않은 사용자"`처럼 default value를 제시하는 것이다.

## 옵셔널 바인딩 연습
```swift
// if let 바인딩 연습
import UIKit

var number: Int? = 7
var noNumber: Int?
var hello: String? = "안녕하세요"
var name: String? = "홍길동"
var noString: String?
var newNum: Double? = 5.5
var noDoubleNumber: Double?

if let num = number {
    print(num)
}

if let hi = hello {
    print(hi)
}

if let realName = name {
    print(realName)
}

if let num = newNum {
    print(num)
}

// guard let 바인딩 연습
func doGuardLetBinding(_ num: Int?) {
    guard let number = num else { return }
    print(number)
}

func doGuardLetBinding(_ str: String?) {
    guard let string = str else { return }
    print(string)
}

func doGuardLetBinding(_ num: Double?) {
    guard let number = num else { return }
    print(number)
}

doGuardLetBinding(number)
doGuardLetBinding(noNumber)
doGuardLetBinding(hello)
doGuardLetBinding(name)
doGuardLetBinding(noString)
doGuardLetBinding(newNum)
doGuardLetBinding(noDoubleNumber)
```

## 옵셔널 타입의 응용
1. Optional Chaining : 옵셔널 체이닝
    - 옵셔널 타입으로 선언된 값에 접근해서 속성, 메서드를 사용할 때 접근연산자 앞에 ?를 붙여야 한다.
    - 앞의 값이 옵셔널 가능성이 있음을 내포한다는 의미다.
    - 결과는 항상 옵셔널 타입으로 리턴되며, 옵셔널 체이닝 과정에서 여러 값 중 하나라도 nil을 반환하면 이어지는 모든 내용을 nil로 반환한다.
2. Implicitly Unwrapped Optionals : 암시적 추출 옵셔널 타입
    - Non-Optional 타입의 변수에 저장될 때 값이 있는 경우 자동으로 값이 추출되어 저장되는 타입
    - 혹은 제한적 상황에서 추출할 준비가 되어있는 타입
    - 일반 변수와 유사한 성질을 가지지만 문법적으로 옵셔널처럼 사용하기 위한 ㅂ2ㅕㄴ수 형식
    - 제한적인 경우 암묵적으로 추출, 굳이 벗기지 않고 사용할 수 있다.
    - `String!`은 `String?`과 동일하다고 생각해도 무방하다.
    - 실제 앱 개발시 스토리보드와 Outlet을 연결할 때 주로 사용함.
    - 위에서 설명하듯 nil을 할당할 수 있으나 값이 있다고 확신이 들 때 사용한다.
3. 함수와 옵셔널 타입
```swift
func doPrint(with label: String, name: String? = nil) {
    // 이하 내용 생략
}
```
옵셔널 타입이기에 nil로 초기화 및 nil값 허용, 함수 사용시 아규먼트 자체를 생략할 수도 있다.

## 자바의 Optional<> 과 비교
Java Spring framework에서 아래와 같은 코드가 있다 가정하자. (불필요 내용 생략)
```java
// UserRepository
@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByEmail(String email);
}

// UserService
@Service
@Transactional
@NoArgsConstructor
public class UserService {
    private final UserRepository userRepository;

    public boolean loginProcess(LoginForm loginForm) {
        Optional<User> userEntity = userRepository.findByEmail(loginForm.getEmail());
        User user = userEntity.get();
        // 이하 로그인 처리로직
    }
}
```
자바에서는 `Optional<T>`의 형태로 사용해서 userEntity가 Null이면 데이터베이스에 값이 존재하지 않는거다.<br>
그말인 즉슨 불필요한 Exception(예외)가 발생할 수 있다는 뜻이고 이를 방지하기 위해 Optional<>에 담아둔 후, 본 객체에 .get()을 사용하여 옮기는 것이다.<br>
Swift에서도 마찬가지다. 변수 선언 후 불필요해져 사용을 안하거나, 지금 당장 사용할 필요가 없는데 표시는 해야하는 경우 옵셔널 처리 하여 nil으로 두면 되는 것이다.