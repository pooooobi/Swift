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

## ? <추가예정>

## 자바의 Optional<> 과 비교
Java Spring framework에서 아래와 같은 코드가 있다 가정하자. (불필요 내용 생략)
```java
// UserRepository

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    // 내용 생략
    Optional<User> findByEmail(String email);
}

// UserService
@Service
@Transactional
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