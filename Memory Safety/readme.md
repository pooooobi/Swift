# 메모리 안전(Memory Safety)
1. 메모리 안전의 개념
    - 싱글 쓰레드의 환경에서도 하나의 메모리에 동시적 접근이 발생할 수 있다.
    - 멀티 쓰레드의 환경에서만 메모리 충돌이 일어나는 것은 아니다.

2. 메모리 접근에 대한 충돌(conflict) 이해하기
```swift
var stepConflict = 1

func increment(_ number: inout Int) {
    number += stepConflict
}

increment(&stepConflict) // 메모리 동시접근으로 인한 문제 발생
// number라는 파라미터가 &stepConflict의 메모리를 공유받고, 내부 함수에서 stepConflict가 존재함에 따라 발생

// 위 문제는 어떻게 해결할까?
var stepSize = 1
var copyOfStepSize = stepSize

func incrementing(_ number: inout Int) {
    number += stepSize
}

incrementing(&copyOfStepSize)
stepSize = copyOfStepSize

func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}

var playerOneScore = 42
var playerTwoScore = 30

// balance(&playerOneScore, &playerOneScore) 금지.
balance(&playerOneScore, &playerTwoScore)
```

3. 구조체의 인스턴스에서의 메모리 안전
    - 메서드에서 self에 대한 접근
```swift
func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}

// 구조체 등의 메서드에서 self에 접근하는 경우 출동한다
// 값 타입은 속성 하나가 아닌 인스턴스 전체에 대한 읽기/쓰기 로 접근

// 구조체 정의
struct Player {
    var name: String
    var health: Int
    var energy: Int

    // 타입 속성
    static let maxHealth = 10

    // health 값을 바꾸는 메서드
    mutating func restoreHealth() {
        health = Player.maxHealth
    }
}

// 확장
extension Player {
    // 자신의 체력과 동료의 체력을 공유하여 평균을 설정함
    mutating func shareHealth(with teammate: inout Player) {
        balance(&teammate.health, &health)
    }
}

var mario = Player(name: "마리오", health: 10, energy: 10)
var luigi = Player(name: "루이지", health: 5, energy: 10)

// "마리오"와 "루이지"의 체력을 공유
mario.shareHealth(with: &luigi) // 괜찮음

// "마리오"와 "마리오"의 체력을 공유하려면 에러
//mario.shareHealth(with: &mario)
```

4. 속성에 대한 접근 출돌의 예시
```swift
// 3번 코드와 이어짐
// 튜플 생성
var playerInformation = (health: 10, energy: 20)

// 튜플에 대한 동시접근 문제
// balance(&playerInformation.health, &playerInformation.energy)

// 전역이 아닌 지역변수로 만들어 접근할 수는 있으나, 전역 변수로 balance에 접근하면 오류가 발생함
```