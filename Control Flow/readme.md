# Programming Basic Principle & Control Flow
모든 프로그래밍은 `순차`, `조건`, `반복` 세가지의 논리로 이루어진다.

## 순차
개발자가 정한 규칙에 따라 순차적으로(차례대로) 실행한다.

## 분기처리
어떤 조건에 따라 선택적으로 코드를 실행시키는 것을 뜻한다.

## 조건문(if) ➞ 자바와 매우 흡사한 느낌
참(true) 또는 거짓(false)의 특정 조건에 따라 특정 코드만 실행하게 할 수 있는 문장을 뜻한다.
- `if 조건문 { }` 의 형식으로 작성
- `if 조건문 { } else if 조건문 { }`의 else if도 사용 가능하다.
- `if 조건문 { } else { }`도 가능하다.
- if 안에 if가 있는 중첩 구조도 사용 가능하다.

if 에서는 논리적인 구조 및 조건의 순서가 중요하다.<br>
논리적인 오류가 없도록 구성하야 하며, 조건 확인 순서도 중요하다.<br><br>
조건 2개도 사용가능하도 응용 범위(모든 조건에 대한 처리가 가능)가 넓다.

## 조건문(switch)
표현식, 변수를 분기처리할 때 사용하는 조건문.<br>
아래와 같이 사용할 수 있다.
```swift
switch 변수 {
    case 값1:
        code
        fallthrough // 매칭 값에 대한 고려없이 무조건 다음 블럭을 실행시키는 키워드
    case 값2, 값3:
        code
    default:
        break
}
```
- 케이스를 콤마(,)로 연결할 수 있으며, switch에서 OR의 의미를 가진다.
- default 케이스는 무조건 필요하다. 케이스는 하나도 빠뜨리는 것 없이 철저(exhaustive)해야 한다.
- 실행하려는 코드가 없을 때, switch에서 `break` 키워드가 반드시 필요하다.
- 매칭된 값에 대해 고려없이 다음 문장도 실행하고 싶을 때 `fallthrough` 키워드를 사용한다.

if 보다 가독성이 좋아, 실제 앱 등의 분기처리에 많이 사용된다.

## 스위치(Switch)의 활용
- Value Binding : 다른 새로운 변수/상수 식별자로 할당한다는 뜻이다.<br>
즉, 새로운 변수로 할당한다는 뜻이다.
```swift
var num = 6

switch num {
    case let a: // let a = num
        print("숫자: \(a)")
    default:
        break
}
```
- where(스위치문에서 조건을 확인하는 방식)<br>
다른 상수 값에 바인딩(값을 넣음)한 후, 조건절(참/거짓)을 통해 다시 조건을 확인함.<br>
바인딩 된 상수는 `케이스 블럭 내부에서만` 사용가능하고, 상수 바인딩은 주로 where 절하고 같이 사용된다.
```swift
var num = 7

// 예시 1
switch num {
    case let x where x % 2 == 0:
        print("짝수 숫자: \(x)")
    case let x where x % 2 != 0:
        print("홀수 숫자: \(x)")
    default:
        break
}

// 예시 2
switch num {
    case let n where n <= 7:
        print("7 이하의 숫자: \(n)")
    default:
        print("그 이외의 숫자")
}

// 예시 3
switch num {
    case var x where x > 5: // 변수로 바인딩도 가능하다. var x = num
        x = 7
        print(x)
    default:
        print(num)
}
```

## 패턴 매칭 연산자
`시작 숫자...끝 숫자 ~= 변수명`으로 사용하며,<br>
 시작 숫자 ~ 끝 숫자가 변수값 안에 포함된다면 `true`, 그렇지 않다면 `false`가 반환된다.<br>
 이외에도 ..<0 (-를 의미함.), 1...(1 이상) 등이 있다.

 ## 가드문(guard)
 if문을 사용할 때 조건이 여러개일 경우 지속적으로 들여써야 하는데, 코드의 가독성이 안좋아져 Swift에는 가드문이 존재한다.

1. else문을 먼저 배치하여 조건을 판별해 조기 종료시킨다.(early exit)
2. 조건을 만족하는 경우 코드가 다음줄로 넘어가서 계속 실행된다.
3. 가드문에서 선언된 변수를 아래 문장에서 사용 가능하다.(동일 스코프로 취급, guard let 바인딩 관련)
```swift
// if문
func checkPassword(password: String) -> Bool {
    if password.count >= 6 {
        // 로그인 처리 로직
        return true
    } else {
        return false
    }
}

// guard문, 가독성이 좋아진 것을 한눈에 볼 수 있음
func checkPassword2(password: String) -> Bool {
    guard password.count >= 6 else { return false }
    // 로그인 처리 로직
    return true
}
```
if 안에 if가 있다면 guard문을 더 늘려 미리 걸러내는 구조라고 생각하면 된다.<br>
`guard`의 사전적 의미인 감시하다와 일치하는 내용이다.<br>
`guard condition else { return }` 의 형태로 사용하면 된다.