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
```