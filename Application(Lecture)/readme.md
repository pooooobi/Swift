# iOS Application
- iOS 앱 개발과 관련해 배웁니다.
- 기본적으로 강의 내용과 연결되어 있어, 개인 프로젝트와는 관련 없습니다.
    - 본인의 이해를 돕기 위해 작성한 것이므로 제 창작물이 아닙니다.

## Delegate Pattern
- 델리게이트 패턴에 대한 이해
    - 어떤 객체와 또 다른 객체 사이의 커뮤니케이션을 담당한다고 생각하면 된다.
```swift
protocol ControlDelegate {
    func up()
    func down()
}

class Controller {
    var delegate: ControlDelegate?

    func up() {
        delegate?.up()
    }

    func down() {
        delegate?.down()
    }
}

class Elevator: ControlDelegate {
    func up() {
        print("엘레베이터가 올라갑니다.")
    }

    func down() {
        print("엘레베이터가 내려갑니다.")
    }
}

let controller = Controller()
let elevator = Elevator()

controller.delegate = elevator

controller.up()
controller.down()
```