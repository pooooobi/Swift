# 비동기 프로그래밍
- 해당 문서에서는 동시성(Concurrency), 동기(sync), 비동기(async) 처리를 다룬다.

1. 비동기 처리가 왜 필요할까?
    - 실제 어플리케이션 내에서 비동기처리 하지 않을 경우 뚝뚝 끊기는 현상도 발생하고 있다.
    - 아이폰의 화면 주사율은 (현재) 60Hz다. 1초에 60번 화면이 다시 생성된다고 보면 된다.
    - 따라서 비동기 처리를 하지 않으면 이런 메커니즘이 제대로 동작하지 않아 화면이 버벅거리게 된다.
    - 결론적으로, 비동기 처리가 필요하고, iOS에서는 대기열을 통한 쓰레드 자동배치로 편리하게 이용할 수 있다.
        - DispatchQueue(GCD: Grand Central DispatchQueue), OpreationQueue 존재
            - 직접적으로 쓰레드를 관리하는 개념이 아닌, 대기열(Queue)의 개념을 이용하여 작업을 분산처리하고 OS에서 쓰레드를 관리
            - 쓰레드 객체를 직접 생성시키거나 하지 않는 위치에서, 쓰레드보다 더 높은 레벨/차원에서 작업을 처리함
            - 메인 쓰레드(1)가 아닌 다른 쓰레드에서 오래 걸리는 작업들과 같은 작업들이 쉽게 비동기적으로 동작함
2. Synchronous(동기), Asynchronous(비동기) 뭐가 다를까 ?
    - 비동기 처리(async)는 작업을 다른 쓰레드로 보내자마자 즉시 리턴된다.
        - 따라서, 다른 일을 바로 처리할 수 있다.
        - 일을 시작시키고 작업이 끝날 때 까지 기다리지 않는 개념
    - 동기처리(sync)는 작업을 다른 쓰레드로 보내고, 그 작업이 끝나 리턴될때 까지 대기상태가 된다.
        - 따라서, 다른 일을 처리할 수 없고 작업이 끝날때까지 "기다린다".
    - 다른 언어에서 사용하는 Blocking, Non-Blocking 개념도 살펴보면 좋다.
        - Non-Blocking(제어권 바로 반환)에서는 동기의 개념이 지속적 완료여부를 회신한다.
3. Serial(직렬), Concurrent(동시)는 뭐가 다를까 ?
    - Serial Queue는 작업이 배치가 되면 하나의 쓰레드로만 배치한다.
        - 다른 한개의 쓰레드에서만 처리하는 큐
    - Concurrent Queue는 작업이 배치가 되면 여러 쓰레드로 배치한다.
        - 다른 여러개의 쓰레드에서 처리하는 큐
    - 분산처리를 하려면 Concurrent Queue가 좋아보이는데 Serial Queue는 언제 사용하나요 ?
        - Serial Queue는 순서가 중요한 작업에서 사용하고, Concurrent Queue는 독립적이지만 유사한 여러개의 작업을 처리할 때 사용한다.
4. `DispatchQueue` 사용 예시
- Concurrent Queue(동시)
```swift
// 정의
let concurrentQueue = DispatchQueue.global()


DispatchQueue.global().async {
    // default global queue 생성
    // 다른 쓰레드로 보낼 작업을 배치한다
}

concurrentQueue.async {

}

// 비동기적인 함수를 만들수도 있다.
func exampleDispatchQueue {
    DispatchQueue.global().async {
        // 세부 코드
    }
}
```
 - Serial Queue(직렬)
    - 해당 코드는 비동기적으로 보내더라도 순서대로 출력된다.
```swift
let serialQueue = DispatchQueue(label: "serial") // 라벨은 어플리케이션 네임(com.example...)

serialQueue.async {
    // 세부 코드
}
```
5. GCD의 개념 및 종류
    - DispatchQueue(GCD)
        - Main Queue: DispatchQueue.main
            - 유일한 한개, 직렬, 실제로는 메인 쓰레드를 가르킴
        - Global Queue: DispatchQueue.global()
            - 종류가 여러개고, 기본설정 동시(Concurrent), QoS(서비스 품질) 6종류를 가짐(아래에서 확인)
            - 주로 default queue, utility queue 사용
        - Private Queue: DispatchQueue(label: "...")
    - OperationQueue
        - Main Queue: OperationQueue.main
        - Private Queue: OperationQueue()
    - 큐의 QoS(Quality of Serive)
        - iOS가 알아서 우선적으로 중요한 일임을 인지하고, 쓰레드에 우선순위를 매겨 더 많은 쓰레드를 배치하고 CPU의 배터리를 더 집중해서 사용하도록 하여 일을 빨리 끝내도록 하는 개념

서비스품질 수준 | 사용 상황 | 소요 시간
:--|:--| :-- 
.userInteractive | 유저와 직접적 인터렉티브 관련 기능(UI 업데이트, 직접적 X / 애니메이션 / UI 관련 반응) | 거의 즉시
.userInitiated | 유저가 즉시 필요하지만 비동기적으로 처리된 작업 | 몇초
.default | 일반적인 작업 | -
.utility | 보통 Progress Indicator(I/O, Networking, 지속적인 데이터 feeds)와 함께 길게 실행되는 작업 및 계산 | 몇초 ~ 몇분
.background | 유저가 직접적으로 인지하지 않고(시간이 중요하지 않은) 작업 | 몇분 이상(속도보다 에너지 효율성 중시)
.unspecified | legacy API 지원(쓰레드를 서비스 품질에서 제외) | -

6. GCD 사용시 주의해야 할 사항
    - 반드시 메인큐에서 처리해야 하는 작업
        - 만약 화면과 관련된(UI Task) 작업의 경우 여러 작업을 다른 쓰레드에서 처리하다가 메인으로 보내야 한다.
            - `DispatchQueue.main.async { }`
    - 컴플리션 핸들러의 존재 이유 : 올바른 콜백함수의 사용
        - (잘못된 함수 설계) 비동기적인 작업을 해야하는 함수를 설계할 때, return을 통해 데이터를 전달하려면 항상 nil이 반환
        - (제대로된 함수 설계) 비동기적인 작업을 해야하는 함수는 항상 클로저를 호출할 수 있도록 함수를 설계해야 함
            - @escaping, completion()
        - GCD 코드를 사용할 경우 작업을 바로 배치하고 반환되기 때문에, return 타입이 있는 함수를 사용하면 안된다.
            - 데이터를 리턴으로 전달하면 안되고, 클로저로 전달해야 함.
                - `@escaping (data name) -> Void`
    - weak, strong 캡처의 주의
        - 일반적으로 비동기 코드는 객체 내에서 사용하게 될 일이 많은데 self를 자주 사용한다.
        - 따라서, 강한참조의 경우 주의해서 사용해야 한다.

```swift
// 반드시 메인큐에서 처리해야 하는 작업
var imageView: UIImageView? = nil

let url = URL(string: "http 주소")!

URLSession.shared.dataTask(with: url) { (data, response, error) in
    if error != nil {
        print("ERROR")
    }

    guard let imageData = data else { return }

    let photoImage = UIImage(data: imageData)

    DispatchQueue.main.async {
        imageView?.image = photoImage
    }
}.resume()

// 혹은

DispatchQueue.global().async {
    // code
    DispatchQueue.main.async {
        // 메인 큐에서 처리해야 하는 작업
    }
}

// 올바른 함수의 설계
func properlyGetImages(with urlString: String, completionHandler: @escaping (UIImage?) -> Void) {
    let url = URL(string: urlString)!

    var photoImage: UIImage? = nil

    URLSession.shared.dataTask(with: url) { (data, response, error) in 
        if error != nil {
            print(error!)
        }

        guard let imageData = data else { return }

        photoImage = UIImage(data: imageData)

        completionHandler(photoImage)
    }.resume()
}

propertyGetImages(with: "url 주소") {
    DispatchQueue.main.async {
        // UI 작업 코드

        // 예시
        imageView?.image = photoImage
    }
}

// weak, strong 캡처의 주의
class ViewController: UIViewController {
    
    var name: String = "뷰컨"
    
    func doSomething() {
        DispatchQueue.global().async {
            sleep(3)
            print("글로벌큐에서 출력하기: \(self.name)")
        }
    }
    
    deinit {
        print("\(name) 메모리 해제")
    }
}


func localScopeFunction() {
    let vc = ViewController()
    vc.doSomething()
}
// 강한 참조를 하기 때문에 3초간 붙잡힌 뒤 해제됨
// 뷰 컨트롤러가 사라져도 출력함.

// 약한 참조
class ViewController1: UIViewController {
    
    var name: String = "뷰컨"
    
    func doSomething() {
        // 강한 참조 사이클이 일어나지 않지만, 굳이 뷰컨트롤러를 길게 잡아둘 필요가 없다면
        // weak self로 선언
        DispatchQueue.global().async { [weak self] in
            guard let weakSelf = self else { return } // return 되어 밑부분 출력 안됨
            sleep(3)
            print("글로벌큐에서 출력하기: \(weakSelf.name)")
        }
    }
    
    deinit {
        print("\(name) 메모리 해제")
    }
}


func localScopeFunction1() {
    let vc = ViewController1()
    vc.doSomething()
}

localScopeFunction1()
```
7. async, await의 도입
    - 비동기 함수를 사용할 경우 return 타입으로 사용하면 안된다. 즉시 반환되기 때문에..
    - 많은 비동기 함수가 있을 경우 `}`가 늘어나 코드 가독성이 떨어져 async, await(JS) 개념이 도입되었다 => Swift 5.5 이후
    - 따라서, 해당 코드를 사용하면 리턴 타입의 함수를 사용할 수 있다. 코드의 가독성도 증가한다.
    - 큐에 배치되어 쓰레드별로 작업이 배치되더라도 작업이 끝나야 다음 작업이 실행된다.
    - 콜백함수를 들여쓰기 할 필요 없이 반환 시점을 기다릴 수 있고, 깔끔한 코드 처리가 가능하다.
```swift
func processImageData() async throws -> Image {
    // 내부 코드
    // ex
    let imageResult = try await dewarpAndCleanupImage(imageTmp)
    return imageResult
}
```
8. 동시성 프로그래밍과 관련된 문제점
    - 경쟁상황, 경쟁조건(Race Condition)
        - 1번 쓰레드에서 작업을 배치시켜 2, 3번 쓰레드에서 작업을 진행한다고 치면, 동시에 접근하는 상황을 말한다.
            - ex) 2번 쓰레드 => 변수 변경, 3번 쓰레드 => 변수 읽기
        - 따라서, Thread-safe 하지 않아 경쟁상황(Race Condition)이라 함.
    - 교착상대, 데드락(DeadLock)
        - 2개 이상의 쓰레드가 서로 베터작인 메모리의 사용으로 인해(서로 잠그고 점유하려고) 메서드의 작업이 종료도 못하고 일의 진행이 멈춰버리는 상태
9. 동시성 프로그래밍 문제점의 해결 방법
    - 도중에 serial queue로 보내는 방법이 있다.
    - 아래 코드는 array에 들어가는 순서는 다르지만, 실제 thread-safe하여 모든 숫자가 들어간다.
```swift
var array = [String]()

let serialQueue = DispatchQueue(label: "serial")

for i in 1...20 {
    DispatchQueue.global().async {
        print(i)
        // array.append("\(i)")

        serialQueue.async { // 올바른 처리방법
            array.append("\(i)")
        }
    }
}

// 5초 뒤 프린트 하는 코드
DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    print(array)
}
```

# 참고(UI 업데이트)
1. UIKit의 모든 속성을 Thread-safe 하게 설계하면, 느려짐과 같은 성능저하가 발생하기 때문에 그렇게 설계할 수 없다.
    - 따라서 개발자가 해당 상황에서 Thread-safe 하게 개발하면 된다.
2. 메인 런루프(runloop)가 뷰의 업데이트를 관리하는 View Drawing Cycle을 통해 뷰를 동시에 업데이트 하는 그런 설계를 통해 동작하고 있는데, 메인 쓰레드가 아닌 백그라운드 쓰레드가 각자의 런루프로 그런 동작을 하게 된다면 뷰가 제멋대로 동작한다.
3. iOS가 그림을 그리는 렌더링 프로세스(Core animation -> 렌더 서버 -> GPU -> out)가 있는데, 여러 쓰레드에서 각자의 뷰의 변경사항을 GPU로 보내면 GPU는 각각의 정보를 다 해석해야 하니 느려지거나 비효율적으로 변한다.
4. Texture나 ComponentKit이라는 페이스북에서 개발한 비동기적 UI Framework가 있으나, 그조차도 View Drawing Cycle이 유사한 방식으로 적절한 타이밍에 메인 쓰레드에서 동시에 업데이트 하도록 하고 있다.
5. 즉, iOS 뿐 아니라 다른 OS에서도 위와 유사한 이유들 때문에 UI update는 메인 쓰레드에서 이루어지도록 하고 있다.